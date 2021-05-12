//
//  Trapezium.swift
//  Trapezium
//
//  Created by Admin on 12.05.2021.
//

import UIKit
import Shape

open class Trapezium: Shape, Codable{

    private let stroke: Stroke
    private let fill: Fill
    private var points = [CGPoint]()
    private var shouldUseHorizontalAxis: Bool?
    
    private enum CodingKeys: String, CodingKey{
        case stroke
        case fill
        case points
    }
    public func draw(isPrototype: Bool) {
        if points.count > 1
        {
            
            let polygonPath = UIBezierPath()
            polygonPath.move(to: points.first!)
            for point in points[1...] {
                polygonPath.addLine(to: point)
            }
            if points.count == 4{
                polygonPath.close()
                fill.color.setFill()
                polygonPath.fill(with: .normal, alpha: fill.opacity)
            }
            
            polygonPath.lineWidth = CGFloat(stroke.width)
            
            stroke.color.setStroke()
            if isPrototype
            {
                let dash = [CGFloat(15.0), CGFloat(15.0)]
                polygonPath.setLineDash(dash, count: 2, phase: CGFloat(30))
            }
            polygonPath.stroke()
            
        }
    }
    
    public func replace(point: CGPoint) {
        let count = points.count
        
        switch count {
            
        case  2:
            if shouldUseHorizontalAxis == nil
            {
                shouldUseHorizontalAxis = horizontalAxis(point1: points[0], point2: points[1])
            }
            if !areColinear(points[0], points[1], point)
            {
                _ = points.popLast()
                points.append(point)
            }
        case 3:
            _ = points.popLast()
            points.append(point)
        case 4:
            let newPoint = makeParallel(points[0], points[1], points[2], point, shouldUseHorizontalAxis: shouldUseHorizontalAxis!)
            _ = points.popLast()
            points.append(newPoint)
        default:
            points.append(point)
        }
        
        
    }
    
    private func areColinear(_ point1: CGPoint, _ point2: CGPoint, _ point3: CGPoint) -> Bool {
        return (point2.y - point1.y)/(point2.x - point1.x) == (point3.y - point1.y)/(point3.x - point1.x)
    }
    
    private func makeParallel(_ point1: CGPoint, _ point2: CGPoint, _ point3: CGPoint, _ point4: CGPoint, shouldUseHorizontalAxis: Bool) -> CGPoint {
        if shouldUseHorizontalAxis
        {
            let y4: CGFloat = (point2.y - point1.y)*(point4.x - point3.x)/(point2.x - point1.x) + point3.y
            return CGPoint(x: point4.x, y: y4)
        }
        else
        {
            let x4 = (point4.y - point3.y)*(point2.x - point1.x)/(point2.y - point1.y) + point3.x
            return CGPoint(x: x4, y: point4.y)
        }
    }
    
    public func add(point: CGPoint) {
        points.append(point)
        
    }
    public func canFinalizeDrawing(afterPanGesture: Bool) -> Bool {
        
        if points.count == 4 {
            return true
        }
        return false
    }

    private func horizontalAxis(point1: CGPoint, point2: CGPoint) -> Bool{
        let deltaX = abs(point1.x - point2.x)
        let deltaY = abs(point1.y - point2.y)
        
        return deltaX >= deltaY
    }
    
    public func encodeShape(in container: KeyedEncodingContainer<ShapeExternalCodingKeys>) throws {
        var encoder = container
        try encoder.encode("Trapezium", forKey: .type)
        try encoder.encode(self, forKey: .data)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(stroke, forKey: .stroke)
        try container.encode(fill, forKey: .fill)
        try container.encode(points, forKey: .points)
    }
    
    public init(stroke: Stroke, fill: Fill, firstPoint: CGPoint) {
        self.stroke = stroke
        self.fill = fill
        self.points.append(firstPoint)
    }
    
    public init(stroke: Stroke, fill: Fill, points: [CGPoint]) {
        self.stroke = stroke
        self.fill = fill
        self.points = points
    }
    
    public convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let points = try container.decode([CGPoint].self, forKey: .points)
        if points.count != 4
        {
            throw ShapeDecodingError.invalidPointsNumber
        }
        let stroke = try container.decode(Stroke.self, forKey: .stroke)
        let fill = try container.decode(Fill.self, forKey: .fill)
        self.init(stroke: stroke, fill: fill, points: points)
        
        
    }
}
