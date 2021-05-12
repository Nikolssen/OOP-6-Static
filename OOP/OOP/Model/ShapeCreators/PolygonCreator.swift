//
//  PolygonCreator.swift
//  OOP
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import CoreGraphics
import Shape

class PolygonCreator: ShapeCreator {
    
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Polygon(stroke: stroke, fill: fill, firstPoint: firstPoint)
    }
    
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let polygon = try container.decode(Polygon.self, forKey: .data)
        return polygon
    }
        
    func shapeName() -> String {
        return "Polygon"
    }
    
    
}
