//
//  NewsCellSizeCalculator.swift
//  VKTest
//
//  Created by Мадияр on 6/21/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

struct Sizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol NewsCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [PhotoAttachment]) -> Sizes
}

final class NewsCellLayoutCalculator: NewsCellLayoutCalculatorProtocol {
    // MARK: - Properties
    
    private let screenWidth: CGFloat
    
    // MARK: - Init
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
     // MARK: - Helpers
    
    func sizes(postText: String?, photoAttachments: [PhotoAttachment]) -> Sizes {
        
        let cellPadding: CGFloat = 16
        
        // MARK: config PostLabel frame
        
        var postLabelFrame = CGRect(origin: CGPoint(x: cellPadding, y: 60),
                                    size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = screenWidth - (cellPadding * 2)
            let height = text.height(width: width, font: UIFont.systemFont(ofSize: 14))
        
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: config CollectionView frame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? 60 : postLabelFrame.maxY + cellPadding
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        
        if let _ = photoAttachments.first {
            
            var photos = [CGSize]()
            for photo in photoAttachments {
                let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                photos.append(photoSize)
            }
            
            let rowHeight = CustomLayout.calculateHeight(superviewWidth: screenWidth, photos: photos)
            let height = calculateHeight(rowHeight: rowHeight, photos: photos)
            
            attachmentFrame.size = CGSize(width: screenWidth, height: height)
        }
        
        // MARK: config BottomView frame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: screenWidth, height: 44))
        
        // MARK: config total height
        
        let totalHeight = bottomViewFrame.maxY
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
    
    private func calculateHeight(rowHeight: CGFloat?, photos: [CGSize]) -> CGFloat {
        guard let height = rowHeight else { return 0 }
        
        switch photos.count {
        case 1,3:
            return height
        case 2:
            if (photos[0].height < photos[0].width) && (photos[1].height < photos[1].width) {
                return height * 2
            } else if (photos[0].height > photos[0].width) && (photos[1].height > photos[1].width) {
                return height / 1.5
            } else {
                return height
            }
        case 4:
            return height * 2
        case 5:
            return (height / 1.5) + height
        default:
            return height * CGFloat(photos.count/2)
        }
        
    }
}
