//
//  RectangleCreator.swift
//  OOP
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import CoreGraphics
import Shape

class RectangleCreator: ShapeCreator {
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Rectangle(stroke: stroke, fill: fill, firstAngle: firstPoint)
    }
    
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let rectangle = try container.decode(Rectangle.self, forKey: .data)
        return rectangle
    }
    
    func shapeName() -> String {
        return "Rectangle"
    }
    
}
