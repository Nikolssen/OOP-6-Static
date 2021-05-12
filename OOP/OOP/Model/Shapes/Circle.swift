//
//  Circle.swift
//  OOP
//
//  Created by Admin on 16.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class Circle: Shape, Codable {
    
    private var radius: CGFloat?
    private let center: CGPoint
    private let stroke: Stroke
    private let fill: Fill
    
    private enum CodingKeys: String, CodingKey {
        case stroke
        case fill
        case radius
        case center
    }
    
    func draw(isPrototype: Bool) {
        if radius != nil {
            let ovalPath = UIBezierPath(arcCenter: center, radius: radius!, startAngle: 0, endAngle: (CGFloat.pi * 2), clockwise: true)
            stroke.color.setStroke()
            ovalPath.lineWidth = CGFloat(stroke.width)
            fill.color.setFill()
            if isPrototype
            {
                let dash = [CGFloat(15.0), CGFloat(15.0)]
                ovalPath.setLineDash(dash, count: 2, phase: CGFloat(30))
            }
            ovalPath.fill(with: .normal, alpha: fill.opacity)
            ovalPath.stroke()
        }
    }
    
    func canFinalizeDrawing(afterPanGesture: Bool) -> Bool {
        return true
    }
    
    func add(point: CGPoint){
    }
    
    func replace(point: CGPoint) {
        let x = center.x - point.x
        let y = center.y - point.y
        radius = sqrt(x*x + y*y)
    }

    func encodeShape(in container: KeyedEncodingContainer<ShapeExternalCodingKeys>) throws {
        var encoder = container
        try encoder.encode("Circle", forKey: .type)
        try encoder.encode(self, forKey: .data)
    }
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stroke, forKey: .stroke)
        try container.encode(fill, forKey: .fill)
        try container.encode(radius, forKey: .radius)
        try container.encode(center, forKey: .center)
    }
    
    init(stroke: Stroke, fill: Fill, center: CGPoint, radius: CGFloat?)
    {
        self.stroke = stroke
        self.fill = fill
        self.center = center
        self.radius = radius
    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let stroke = try container.decode(Stroke.self, forKey: .stroke)
        let fill = try container.decode(Fill.self, forKey: .fill)
        let center = try container.decode(CGPoint.self, forKey: .center)
        let radius = try container.decode(CGFloat.self, forKey: .radius)
        self.init(stroke: stroke, fill: fill, center: center, radius: radius)
    }
    
}
