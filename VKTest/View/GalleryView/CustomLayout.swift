//
//  CustomLayout.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

protocol CustomLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class CustomLayout: UICollectionViewLayout {
    
    weak var delegate: CustomLayoutDelegate!
    
    private var offset: CGFloat = 5
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }
    
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.height
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    private let calulator = LayoutCalculator()
    
    override func prepare() {

        cache = []
        guard let collectionView = collectionView else { return }
        
        var photos = [CGSize]()
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        
        let maxWidth = collectionView.frame.width
        var frames: [CGRect] = []
        let rowHeight = CustomLayout.calculateHeight(superviewWidth: maxWidth, photos: photos)
        
        switch collectionView.numberOfItems(inSection: 0) {
        case 0:
            break
        case 1:
            frames = calulator.oneCell(photos: photos, maxWidth: maxWidth)
        case 2:
            frames = calulator.twoCells(photos: photos, maxWidth: maxWidth, rowHeight: rowHeight!)
        case 3:
            frames = calulator.threeCells(photos: photos, maxWidth: maxWidth, rowHeight: rowHeight!)
        case 4:
            frames = calulator.fourCells(photos: photos, maxWidth: maxWidth, rowHeight: rowHeight!)
        case 5:
            frames = calulator.fiveCells(photos: photos, maxWidth: maxWidth, rowHeight: rowHeight!)
        default:
            frames = calulator.otherCells(photos: photos, maxWidth: maxWidth, rowHeight: rowHeight!)
        }
        
        for i in 0 ..< frames.count {
            let attribute = UICollectionViewLayoutAttributes(forCellWith: IndexPath(row: i, section: 0))
            attribute.frame = frames[i]
            cache.append(attribute)
        }
    }
    
    // MARK: - calculate frames for cells
    
    static func calculateHeight(superviewWidth: CGFloat, photos: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        
        let photoWithMinRatio = photos.min { (first, second) -> Bool in
            (first.height / first.width) < (second.height / second.width)
        }
        
        guard let myPhotoWithMinRatio = photoWithMinRatio else { return nil }
        
        let difference: CGFloat
        
        if photos.count >= 4 {
            difference = (superviewWidth/2) / myPhotoWithMinRatio.width
        } else {
            difference = superviewWidth / myPhotoWithMinRatio.width
        }
        
        rowHeight = myPhotoWithMinRatio.height * difference
        
        return rowHeight
    }
    
    // MARK: - return Attribuetes
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attatibute in cache {
            if attatibute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attatibute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
}
