//
//  LayoutCalculator.swift
//  VKTest
//
//  Created by Мадияр on 6/22/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

class LayoutCalculator {
    
    private var offset: CGFloat = 3
    
    func oneCell(photos: [CGSize], maxWidth: CGFloat) -> [CGRect] {
        let difference = maxWidth / photos[0].width
        let rowHeight = photos[0].height * difference
        
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: 0, width: maxWidth, height: rowHeight))
        
        return frames
    }
    
    func twoCells(photos: [CGSize], maxWidth: CGFloat, rowHeight: CGFloat) -> [CGRect] {
        
        if (photos[0].height < photos[0].width) && (photos[1].height < photos[1].width) {
            
            var frames = [CGRect]()
            frames.append(CGRect(x: 0, y: 0, width: maxWidth, height: rowHeight))
            frames.append(CGRect(x: 0, y: rowHeight + offset, width: maxWidth, height: rowHeight))
            
            return frames
            
        } else if (photos[0].height > photos[0].width) && (photos[1].height > photos[1].width) {
            
            var frames = [CGRect]()
            frames.append(CGRect(x: 0, y: 0, width: maxWidth / 2, height: rowHeight / 1.5))
            frames.append(CGRect(x: maxWidth / 2 + offset, y: 0, width: maxWidth / 2, height: rowHeight / 1.5))
            
            return frames
            
        } else {
            
            if photos[0].width > photos[1].width {
                
                var frames = [CGRect]()
                frames.append(CGRect(x: 0, y: 0.0, width: maxWidth * 0.6, height: rowHeight))
                frames.append(CGRect(x: maxWidth * 0.6 + offset, y: 0.0, width: maxWidth * 0.4 - offset, height: rowHeight))
                
                return frames
                
            } else {
                
                var frames = [CGRect]()
                frames.append(CGRect(x: 0, y: 0.0, width: maxWidth * 0.4, height: rowHeight))
                frames.append(CGRect(x: maxWidth * 0.4 + offset, y: 0.0, width: maxWidth * 0.6 - offset, height: rowHeight))
                
                return frames
                
            }
            
        }
    }
    
    func threeCells(photos: [CGSize], maxWidth: CGFloat, rowHeight: CGFloat) -> [CGRect] {
        
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: 0, width: maxWidth / 2, height: rowHeight))
        frames.append(CGRect(x: maxWidth / 2 + offset, y: 0, width: maxWidth / 2, height: rowHeight / 2))
        frames.append(CGRect(x: maxWidth / 2 + offset, y: rowHeight/2 + offset, width: maxWidth / 2, height: rowHeight / 2 - offset))
        
        return frames
        
    }
    
    func fourCells(photos: [CGSize], maxWidth: CGFloat, rowHeight: CGFloat) -> [CGRect] {
        
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: 0, width: maxWidth / 2, height: rowHeight))
        frames.append(CGRect(x: 0, y: rowHeight + offset, width: maxWidth / 2, height: rowHeight - offset))
        frames.append(CGRect(x: maxWidth / 2 + offset, y: 0, width: maxWidth / 2, height: rowHeight))
        frames.append(CGRect(x: maxWidth / 2 + offset, y: rowHeight + offset, width: maxWidth / 2, height: rowHeight - offset))
        
        return frames
        
    }
    
    func fiveCells(photos: [CGSize], maxWidth: CGFloat, rowHeight: CGFloat) -> [CGRect] {
        
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: 0, width: maxWidth / 2, height: rowHeight))
        frames.append(CGRect(x: maxWidth / 2 + offset, y: 0, width: maxWidth / 2, height: rowHeight))
        frames.append(CGRect(x: 0, y: rowHeight + offset, width: maxWidth / 3, height: rowHeight / 1.5))
        frames.append(CGRect(x: maxWidth / 3 + offset, y: rowHeight + offset, width: maxWidth / 3 - offset, height: rowHeight / 1.5))
        frames.append(CGRect(x: (maxWidth / 3) * 2 + offset, y: rowHeight + offset, width: maxWidth / 3, height: rowHeight / 1.5))
        
        return frames
        
    }
    
    func otherCells(photos: [CGSize], maxWidth: CGFloat, rowHeight: CGFloat) -> [CGRect] {
        
        var frames = [CGRect]()
        
        var yOffset: CGFloat = 0
        let widht: CGFloat = maxWidth / 2
        var xOffset: CGFloat = 0
        
        photos.forEach { _ in
            frames.append(CGRect(x: xOffset, y: yOffset, width: widht, height: rowHeight))
            
            xOffset += widht + offset
            if xOffset > maxWidth {
                yOffset += (rowHeight) + offset
                xOffset = 0
            }
        }
        
        return frames
    }
}
