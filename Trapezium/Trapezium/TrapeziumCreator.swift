//
//  TrapeziumCreator.swift
//  Trapezium
//
//  Created by Admin on 12.05.2021.
//
import CoreGraphics
import Shape

open class TrapeziumCreator: ShapeCreator {
    public func shape(stroke: Stroke, fill: Fill, firstPoint: CGPoint) -> Shape {
        return Trapezium(stroke: stroke, fill: fill, firstPoint: firstPoint)
    }
    
    public func shape(from container: KeyedDecodingContainer<ShapeExternalCodingKeys>) throws -> Shape {
        let trapezium = try container.decode(Trapezium.self, forKey: .data)
        return trapezium
    }
    
    
    public func shapeName() -> String {
        return "Trapezium"
    }
    public init(){
        
    }
    
}
