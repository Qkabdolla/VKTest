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
    
    init() {
        let layout = CustomLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        dataSource = self
        backgroundColor = .white
        register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        
        if let layout = collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageData: [PhotoAttachment]) {
        self.imageData = imageData
        reloadData()
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

extension GalleryCollectionView: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
        let height = imageData[indexPath.row].height
        let width = imageData[indexPath.row].width
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}
