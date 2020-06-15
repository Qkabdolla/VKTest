//
//  DoubleLayout.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

protocol RowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class DoubleLayout: UICollectionViewLayout {
    
    weak var delegate: RowLayoutDelegate!
    
    static var numbersOfRows = 2
    private var offset: CGFloat = 5
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let superviewWidth = collectionView.frame.width
    }
    
}
