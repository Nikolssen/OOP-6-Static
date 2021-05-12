//
//  OvalCreator.swift
//  OOP
//
//  Created by Admin on 05.05.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import CoreGraphics
import Shape

class OvalCreator: ShapeCreator {
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Oval(stroke: stroke, fill: fill, firstAngle: firstPoint)
    }
    
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let oval = try container.decode(Oval.self, forKey: .data)
        return oval
    }
    
    func shapeName() -> String {
        return "Oval"
    }
    
}
