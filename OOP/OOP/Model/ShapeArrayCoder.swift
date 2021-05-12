//
//  ShapeArrayCoder.swift
//  OOP
//
//  Created by Admin on 04.04.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import Foundation
import Shape

class ShapeArrayCoder: Codable {
    
    var shapes: [Shape]?
    
    init(shapes: [Shape]) {
        self.shapes = shapes
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for shape in self.shapes!
        {
            let shapeContainer = container.nestedContainer(keyedBy: ShapeExternalCodingKeys.self)
            try? shape.encodeShape(in: shapeContainer)
        }
    }
    
    required init(from decoder: Decoder) throws {
        var shapes = [Shape]()
        if var container = try? decoder.unkeyedContainer()
        {
            let helper = ShapeOptions()
            while (!container.isAtEnd) {
                do{
                let shapeContainer = try container.nestedContainer(keyedBy: ShapeExternalCodingKeys.self)
                let shapeTypeString = try shapeContainer.decode(String.self, forKey: .type)
                helper.chooseShape(by: shapeTypeString)
                let shape = try helper.creator.shape(from: shapeContainer)
                shapes.append(shape)
                }
                catch {continue}
            }
        }
        self.shapes = shapes
    }
    
}
