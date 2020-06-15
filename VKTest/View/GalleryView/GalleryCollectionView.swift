//
//  GalleryCollectionView.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit
import Kingfisher

final class GalleryCollectionView: UICollectionView {
    
    private var imageData = [PhotoAttachment]()
    private lazy var layout: SquareMosaicLayout = self.getViewLayout(count: 0)
    
    init() {
        let layout = Layout(pattern: VerticalMosaicPattern())
        super.init(frame: .zero, collectionViewLayout: layout)
        dataSource = self
        backgroundColor = .white
        register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageData: [PhotoAttachment]) {
        self.imageData = imageData
        setCollectionViewLayout(getViewLayout(count: imageData.count), animated: false)
        reloadData()
    }
    
    private func getViewLayout(count: Int) -> SquareMosaicLayout {
        switch count {
        case 1:
            return Layout(pattern: VerticalSinglePattern())
        case 2:
            return Layout(pattern: VerticalDoublePattern())
        case 3:
            return Layout(pattern: VerticalTriplePattern())
        case 4:
            return Layout(pattern: VerticalFourPattern())
        case 5:
            return Layout(pattern: VerticalFivePattern())
        default:
            return Layout(pattern: VerticalMosaicPattern())
        }
    }
}

extension GalleryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell

        if let imageURL = imageData[indexPath.row].urlPhoto {
            let resourse = ImageResource(downloadURL: URL(string: imageURL)!)
            cell.imageView.kf.indicatorType = .activity
            cell.imageView.kf.setImage(with: resourse)
        }
        
        return cell
    }
}
