//
//  LineCreator.swift
//  OOP
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import CoreGraphics
import Shape

class LineCreator: ShapeCreator{
    
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Line(stroke: stroke, firstPoint: firstPoint)
    }
    
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let line = try container.decode(Line.self, forKey: .data)
        return line
    }
    
    func shapeName() -> String {
        return "Line"
    }
    
    
}
