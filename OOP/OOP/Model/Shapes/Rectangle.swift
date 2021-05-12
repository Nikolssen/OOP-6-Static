//
//  Rectangle.swift
//  OOP
//
//  Created by Admin on 12.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class Rectangle: Shape, Codable{
    
    private let firstAngle: CGPoint
    private var secondAngle: CGPoint?
    var height: CGFloat {get{
        return abs(firstAngle.y - (secondAngle?.y ?? firstAngle.y))
        }}
    var width: CGFloat {get {
        return abs(firstAngle.x - (secondAngle?.x ?? firstAngle.x))
        }}
    var x: CGFloat {get{
        return firstAngle.x < secondAngle!.x ? firstAngle.x : secondAngle!.x}
    }
    var y: CGFloat {get{
        return firstAngle.y < secondAngle!.y ? firstAngle.y : secondAngle!.y
        }}
    
    private let stroke: Stroke
    private let fill: Fill
    
    private enum CodingKeys: String, CodingKey{
        case stroke
        case fill
        case points
    }
    
    func draw(isPrototype: Bool) {
        if secondAngle != nil {
            
            let rectanglePath = UIBezierPath(rect: CGRect(x: x, y: y, width: width, height: height))
            stroke.color.setStroke()
            rectanglePath.lineWidth = CGFloat(stroke.width)
            if isPrototype
            {
                let dash = [CGFloat(15.0), CGFloat(15.0)]
                rectanglePath.setLineDash(dash, count: 2, phase: CGFloat(30))
            }
            fill.color.setFill()
            rectanglePath.fill(with: .normal, alpha: fill.opacity)
            rectanglePath.stroke()
        }
    }
    
    
    func replace(point:CGPoint)  {
        secondAngle = point
    }

    func canFinalizeDrawing(afterPanGesture: Bool) -> Bool {
        return true
    }
    
    func add(point: CGPoint){
    }
    
    func encodeShape(in container: KeyedEncodingContainer<ShapeExternalCodingKeys>) throws {
        var encoder = container
        try encoder.encode("Rectangle", forKey: .type)
        try encoder.encode(self, forKey: .data)
    }

    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stroke, forKey: .stroke)
        try container.encode(fill, forKey: .fill)
        try container.encode([firstAngle, secondAngle!], forKey: .points)
    }
    
    init(stroke: Stroke, fill: Fill, firstAngle: CGPoint, secondAngle: CGPoint? = nil) {
        self.stroke = stroke
        self.fill = fill
        self.firstAngle = firstAngle
        self.secondAngle = secondAngle
        self.secondAngle = secondAngle

    }
    
    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let points = try container.decode([CGPoint].self, forKey: .points)
        if points.count < 2
        {
            throw ShapeDecodingError.invalidPointsNumber
        }
        let stroke = try container.decode(Stroke.self, forKey: .stroke)
        let fill = try container.decode(Fill.self, forKey: .fill)
        self.init(stroke: stroke, fill: fill, firstAngle:points.first!, secondAngle: points.last!)
    }
}
