//
//  ShapeOptions.swift
//  OOP
//
//  Created by Admin on 13.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape
import Trapezium
class ShapeOptions{
    private(set) static var availableCreators: [ShapeCreator] = [LineCreator(), PolygonCreator(), RectangleCreator(), OvalCreator(), CircleCreator(), TrapeziumCreator()]
    
    private(set) var creator: ShapeCreator = availableCreators.first!
    
    
    func chooseShape(at index: Int) {
        if index < ShapeOptions.availableCreators.count && index >= 0 {
            creator = ShapeOptions.availableCreators[index]
        }
    }
    
    func chooseShape(by name: String) {
        creator = ShapeOptions.availableCreators[1]
        for shapeCreator in ShapeOptions.availableCreators {
            if name == shapeCreator.shapeName() {
                creator = shapeCreator
                break
            }
        }
    }
}
