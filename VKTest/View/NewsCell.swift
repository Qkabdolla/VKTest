//
//  NewsCell.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit
import Kingfisher

struct FeedCell {
    let sourceId: Int
    let name: String
    let text: String
    let date: String
    let comments: String?
    let likes: String?
    let reposts: String?
    let views: String?
    let attachments: [PhotoAttachment]
    let avatar: String
    let sizes: Sizes
}

struct PhotoAttachment {
    var urlPhoto: String?
    var width: Int
    var height: Int
}

final class NewsCell: UITableViewCell {
    // MARK: - Properties
    
    static let reuseId = "NewsFeedCell"
    
    private lazy var topView: HeaderView = {
        let view = HeaderView()
        return view
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var collectionView = GalleryCollectionView()
    
    private lazy var bottomView: FooterView = {
        let view = FooterView()
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        topView.avatarView.image = nil
    }
    
    // MARK: - Helpers
    
    func configureCell(item: FeedCell) {
        postLabel.text = item.text
        topView.title = item.name
        topView.date = item.date
        
        bottomView.configure(commnets: item.comments,
                             likes: item.likes,
                             shares: item.reposts,
                             views: item.views)
        
        if let avatarURL = URL(string: item.avatar) {
            let resourse = ImageResource(downloadURL: avatarURL)
            topView.avatarView.kf.setImage(with: resourse)
        }
        
        postLabel.frame = item.sizes.postLabelFrame
        collectionView.frame = item.sizes.attachmentFrame
        bottomView.frame = item.sizes.bottomViewFrame
        
        collectionView.set(imageData: item.attachments)
    }
    
    // MARK: - Configure UI
    
    private func configureUI() {
        selectionStyle = .none
        
        addSubview(topView)
        topView.anchor(top: topAnchor,
                       left: leftAnchor,
                       right: rightAnchor,
                       height: 60)
        
        addSubview(postLabel)
        addSubview(collectionView)
        addSubview(bottomView)
    }
    
}
