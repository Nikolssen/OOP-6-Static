//
//  CircleCreator.swift
//  OOP
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import CoreGraphics
import Shape

class CircleCreator: ShapeCreator {
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Circle(stroke: stroke, fill: fill, center: firstPoint, radius: nil)
    }
    
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let circle = try container.decode(Circle.self, forKey: .data)
        return circle
    }
    
    func shapeName() -> String {
        return "Circle"
    }
    
}
