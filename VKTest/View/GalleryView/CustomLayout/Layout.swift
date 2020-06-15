//
//  Layout.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

open class SquareMosaicLayout: UICollectionViewLayout {
    
    fileprivate let collectionViewForcedSize: CGSize?
    fileprivate var object: SquareMosaicObject? = nil
    
    public weak var dataSource: SquareMosaicDataSource?
    public weak var delegate: SquareMosaicDelegate? {
        didSet {
            delegate?.layoutContentSizeChanged(to: collectionViewContentSize)
        }
    }
    
    override open var collectionViewContentSize: CGSize {
        return collectionViewContentSizeVertical
    }
    
    public init(size collectionViewForcedSize: CGSize? = nil) {
        self.collectionViewForcedSize = collectionViewForcedSize
        super.init()
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    open override func prepare() {
        let numberOfItemsInSections = collectionView?.numberOfItemsInSections ?? []
        let size = collectionViewContentSize
        object = SquareMosaicObject(numberOfItemsInSections, dataSource, size)
    }

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return object?.layoutAttributesForItem(at: indexPath)
    }
    
    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return object?.layoutAttributesForElements(in: rect)
    }
    
    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return object?.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
    }
    
    open override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView?.contentOffset ?? CGPoint.zero
    }
}

fileprivate extension SquareMosaicLayout {

    var collectionViewContentSizeVertical: CGSize {
        let height = object?.contentSize ?? 0.0
        let width = collectionViewForcedSize?.width ?? collectionView?.collectionViewVisibleContentWidth ?? 0.0
        return CGSize(width: width, height: height)
    }
}

fileprivate extension UICollectionView {

    var collectionViewVisibleContentHeight: CGFloat {
        return bounds.height - contentInset.top - contentInset.bottom
    }

    var collectionViewVisibleContentWidth: CGFloat {
        return bounds.width - contentInset.left - contentInset.right
    }
}

fileprivate extension UICollectionView {

    var numberOfItemsInSections: [Int] {
        var array = [Int](repeating: 0, count: numberOfSections)
        for section in 0 ..< numberOfSections {
            array[section] = numberOfItems(inSection: section)
        }
        return array
    }
}

