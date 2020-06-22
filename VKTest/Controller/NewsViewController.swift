//
//  MainViewController.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    // MARK: - Properties
    
    private var items = [FeedCell]()
    private var startFrom: String?
    
    private var cellLayoutCalculator: NewsCellLayoutCalculatorProtocol = NewsCellLayoutCalculator()
     
    private lazy var footerView: TableFooterView = TableFooterView()
    
    private lazy var refresher: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        return rc
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        congigureTableView()
        
        getNews()
    }
    
    // MARK: - API
    
    private func getNews() {
        NetworkService.shared.getNewsFeed(startFrom: startFrom, complitionHandler: { [weak self] result in
            let cells = result.response.items.map { (item) in
                self?.populateData(items: item, profiles: result.response.profiles, groups: result.response.groups)
            }
            
            cells.forEach { (item) in
                self?.items.append(item!)
            }
            self?.startFrom = result.response.nextFrom
            
            self?.tableView.reloadData()
            self?.refresher.endRefreshing()
            self?.footerView.title = String(self!.items.count)
        }) { (error) in
            print(error.description)
        }
    }
    
    // MARK: - Helpers
    
    @objc private func didRefresh() {
        getNews()
    }
    
    // MARK: - Helpers
    
    private func populateData(items: FeedItem, profiles: [Profile], groups: [Group]) -> FeedCell {
        let profile = self.profile(for: items.sourceId, profiles: profiles, groups: groups)
        
        let photoAttachments = self.photoAttachments(feedItem: items)
        
        let date = Date(timeIntervalSince1970: items.date)
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        let dateTitle = dt.string(from: date)
        
        let sizes = cellLayoutCalculator.sizes(postText: items.text, photoAttachments: photoAttachments)
        
        return FeedCell(sourceId: items.sourceId,
                        name: profile.name,
                        text: items.text ?? "",
                        date: dateTitle,
                        comments: counterFilter(counter: items.comments?.count),
                        likes: counterFilter(counter: items.likes?.count),
                        reposts: counterFilter(counter: items.reposts?.count),
                        views: counterFilter(counter: items.views?.count),
                        attachments: photoAttachments,
                        avatar: profile.photo,
                        sizes: sizes)
    }
    
    private func counterFilter(counter: Int?) -> String {
        guard let counter = counter, counter > 0 else { return "      " }
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable {
        let profilesOrGroups: [ProfileRepresenatable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresenatable = profilesOrGroups.first { (myProfileRepresenatable) -> Bool in
            myProfileRepresenatable.id == normalSourseId
        }
        return profileRepresenatable!
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [PhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        
        return attachments.compactMap({ (attachment) -> PhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return PhotoAttachment(urlPhoto: photo.srcBIG,
                                   width: photo.width,
                                   height: photo.height)
        })
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        view.backgroundColor = .systemBlue
    }
    
    private func congigureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInset.top = 8
        
        tableView.tableFooterView = footerView
        tableView.addSubview(refresher)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseId)
    }
}

extension NewsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseId, for: indexPath) as! NewsCell
        cell.configureCell(item: items[indexPath.row])
        return cell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y > scrollView.contentSize.height * 0.95 {
            footerView.showActivityView()
            getNews()
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].sizes.totalHeight
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.row].sizes.totalHeight
    }

}
