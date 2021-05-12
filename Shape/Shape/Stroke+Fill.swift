//
//  Stroke+Fill.swift
//  Shape
//
//  Created by Admin on 12.05.2021.
//

import Foundation
import UIKit

public struct Stroke: Codable {
    private(set) public var color: UIColor
    private(set) public var width: Int
    
    enum CodingKeys: String, CodingKey {
        case color
        case width
    }
    
    public mutating func setWidth(_ width: Int) {
        switch width {
        case let x where x < 1:
            self.width = 1
        case let x where x > 10:
            self.width = 10
        default:
            self.width = width
        }
    }
    public mutating func setColor(_ color: UIColor){
        self.color = color
    }
    
    public init(color: UIColor, width: Int){
        self.color = color
        switch width {
        case let x where x < 1:
            self.width = 1
        case let x where x > 10:
            self.width = 10
        default:
            self.width = width
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(color.hexDescription(), forKey: .color)
        try? container.encode(width, forKey: .width)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hex = try container.decode(String.self, forKey: .color)
        let color = UIColor(hex: hex)
        let width = try container.decode(Int.self, forKey: .width)
        self.init(color: color, width: width)
    }
    
}

public struct Fill: Codable {
    private(set) public var color: UIColor
    private(set) public var opacity: CGFloat
    
    enum CodingKeys: String, CodingKey {
        case color
        case opacity
    }
    
    public mutating func setColor(_ color: UIColor){
        self.color = color
    }
    
    public mutating func setOpacity(_ opacity: CGFloat) {
        switch opacity {
        case let x where x < 0.0:
            self.opacity = 0.0
        case let x where x > 1.0:
            self.opacity = 1.0
        default:
            self.opacity = opacity
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(color.hexDescription(), forKey: .color)
        try? container.encode(opacity, forKey: .opacity)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let hex = try container.decode(String.self, forKey: .color)
        let newColor = UIColor(hex: hex)
        let newOpacity = try container.decode(CGFloat.self, forKey: .opacity)
        self.init(color: newColor, opacity: newOpacity)
    }
    public init(color: UIColor, opacity: CGFloat) {
        self.color = color
        self.opacity = opacity
    }
}
