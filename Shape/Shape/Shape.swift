//
//  Shape.swift
//  Shape
//
//  Created by Admin on 12.05.2021.
//

import Foundation
import CoreGraphics

public protocol Shape {
    
    func draw(isPrototype: Bool)
    func replace(point:CGPoint)
    func add(point: CGPoint)
    func canFinalizeDrawing(afterPanGesture: Bool) -> Bool
    func encodeShape(in container: KeyedEncodingContainer<ShapeExternalCodingKeys>) throws
}
public enum ShapeExternalCodingKeys: String, CodingKey
{
    case type
    case data
}

public enum ShapeDecodingError: Error
{
    case invalidPointsNumber
}
