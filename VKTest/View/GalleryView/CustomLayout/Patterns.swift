//
//  Patterns.swift
//  VKTest
//
//  Created by Мадияр on 6/14/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import UIKit

final class Layout: SquareMosaicLayout, SquareMosaicDataSource {
    
    let pattern: SquareMosaicPattern
    
    required init(pattern: SquareMosaicPattern) {
        self.pattern = pattern
        super.init()
        self.dataSource = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutPattern(for section: Int) -> SquareMosaicPattern {
        switch section {
        default:    return pattern
        }
    }
    
    func layoutSeparatorBetweenSections() -> CGFloat {
        return offset
    }
    
}

let offset: CGFloat = 2.0

class VerticalMosaicPattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalTripleBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

class VerticalTriplePattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalOneTwoBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

class VerticalDoublePattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalThreeTwoBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

class VerticalSinglePattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalSingleBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

class VerticalFourPattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalFourBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

class VerticalFivePattern: SquareMosaicPattern {
    
    func patternBlocks() -> [SquareMosaicBlock] {
        return [
            VerticalThreeTwoBlock(),
            VerticalTripleBlock()
        ]
    }
    
    func patternBlocksSeparator(at position: SquareMosaicBlockSeparatorPosition) -> CGFloat {
        return position == .between ? offset : 0.0
    }
}

public class VerticalThreeTwoBlock: SquareMosaicBlock {
    
    public func blockFrames() -> Int {
        return 2
    }
    
    public func blockFrames(origin: CGFloat, side: CGFloat) -> [CGRect] {
        let min = (side - offset * 3) / 2.0
        let max = side - min - offset
        let height = UIScreen.main.bounds.height * 0.6
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: origin, width: max, height: height))
        frames.append(CGRect(x: max + offset, y: origin, width: max, height: height))
        return frames
    }
}

public class VerticalTripleBlock: SquareMosaicBlock {
    
    public func blockFrames() -> Int {
        return 3
    }
    
    public func blockFrames(origin: CGFloat, side: CGFloat) -> [CGRect] {
        let min = (side - offset * 2) / 3.0
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: origin, width: min, height: min))
        frames.append(CGRect(x: min + offset, y: origin, width: min, height: min))
        frames.append(CGRect(x: min * 2 + offset * 2, y: origin, width: min, height: min))
        return frames
    }
    
    public func blockRepeated() -> Bool {
        return true
    }
}

public class VerticalFourBlock: SquareMosaicBlock {
    
    public func blockFrames() -> Int {
        return 4
    }
    
    public func blockFrames(origin: CGFloat, side: CGFloat) -> [CGRect] {
        let min = (side - offset * 4) / 3.0
        let max = side - min - offset
        let height = UIScreen.main.bounds.height * 0.6 - offset
        let smallHeight = height / 3
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: origin, width: max, height: height))
        frames.append(CGRect(x: max + offset, y: origin, width: min, height: smallHeight))
        frames.append(CGRect(x: max + offset, y: origin + smallHeight + offset, width: min, height: smallHeight))
        frames.append(CGRect(x: max + offset, y: origin + (smallHeight + offset) * 2, width: min, height: smallHeight - offset * 2))
        return frames
    }
    
    public func blockRepeated() -> Bool {
        return true
    }
}

public class VerticalSingleBlock: SquareMosaicBlock {
    
    public func blockFrames() -> Int {
        return 1
    }
    
    public func blockFrames(origin: CGFloat, side: CGFloat) -> [CGRect] {
        var frames = [CGRect]()
        let height = UIScreen.main.bounds.height * 0.6
        frames.append(CGRect(x: 0, y: origin, width: side, height: height))
        return frames
    }
    
    public func blockRepeated() -> Bool {
        return false
    }
}

public class VerticalOneTwoBlock: SquareMosaicBlock {
    
    public func blockFrames() -> Int {
        return 3
    }
    
    public func blockFrames(origin: CGFloat, side: CGFloat) -> [CGRect] {
        let min = (side - offset * 4) / 3.0
        let max = side - min - offset
        let height = UIScreen.main.bounds.height * 0.6
        var frames = [CGRect]()
        frames.append(CGRect(x: 0, y: origin, width: max, height: height))
        frames.append(CGRect(x: max + offset, y: origin, width: min, height: height / 2))
        frames.append(CGRect(x: max + offset, y: origin + height/2 + offset, width: min, height: height / 2 - offset))
        return frames
    }
}
