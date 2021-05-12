//
//  ShapeCreator.swift
//  Shape
//
//  Created by Admin on 12.05.2021.
//

import Foundation
import CoreGraphics

public protocol ShapeCreator {
    func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape
    func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape
    func shapeName() -> String
}
