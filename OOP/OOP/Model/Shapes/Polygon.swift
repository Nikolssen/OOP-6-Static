//
//  Polygon.swift
//  OOP
//
//  Created by Admin on 13.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class Polygon: Shape, Codable{
    
    private let stroke: Stroke
    private let fill: Fill
    private var points = [CGPoint]()
    
    private enum CodingKeys: String, CodingKey{
        case stroke
        case fill
        case points
    }
    
    func draw(isPrototype: Bool) {
        if points.count > 1
        {
            
            let polygonPath = UIBezierPath()
            polygonPath.move(to: points.first!)
            for point in points[1...] {
                polygonPath.addLine(to: point)
            }
            polygonPath.close()
            polygonPath.lineWidth = CGFloat(stroke.width)
            fill.color.setFill()
            stroke.color.setStroke()
            if isPrototype
            {
                let dash = [CGFloat(15.0), CGFloat(15.0)]
                polygonPath.setLineDash(dash, count: 2, phase: CGFloat(30))
            }
            polygonPath.fill(with: .normal, alpha: fill.opacity)
            polygonPath.stroke()
            
        }
    }
    
    func add(point: CGPoint) {
        points.append(point)
    }
    
    func replace(point: CGPoint) {
        if (points.count>1) {
            _ = points.popLast()
        }
        points.append(point)
    }
    
    func canFinalizeDrawing(afterPanGesture: Bool) -> Bool {
        if points.count > 2
        {return !afterPanGesture}
        return false
    }
    

    
    func encodeShape(in container: KeyedEncodingContainer<ShapeExternalCodingKeys>) throws {
        var encoder = container
        try encoder.encode("Polygon", forKey: .type)
        try encoder.encode(self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stroke, forKey: .stroke)
        try container.encode(fill, forKey: .fill)
        try container.encode(points, forKey: .points)
    }
    
    init(stroke: Stroke, fill: Fill, firstPoint: CGPoint) {
        
        self.stroke = stroke
        self.fill = fill
        self.points.append(firstPoint)
    }
    
    init(stroke: Stroke, fill: Fill, points: [CGPoint]) {
        self.stroke = stroke
        self.fill = fill
        self.points = points
        }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let points = try container.decode([CGPoint].self, forKey: .points)
        if points.count < 2
        {
            throw ShapeDecodingError.invalidPointsNumber
        }
        let stroke = try container.decode(Stroke.self, forKey: .stroke)
        let fill = try container.decode(Fill.self, forKey: .fill)
        self.init(stroke: stroke, fill: fill, points: points)
    }
}
