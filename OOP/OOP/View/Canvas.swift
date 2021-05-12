//
//  Canvas.swift
//  OOP
//
//  Created by Admin on 28.02.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class Canvas: UIView {
    
    
    weak var datasource: CanvasDatasource?;
    
    override func draw(_ rect: CGRect) {
        
        if let shapes = datasource?.shapes {
            
            for shape in shapes {
                shape.draw(isPrototype: false)
            }
        }
        if let newShape = datasource?.currentShape {
            newShape.draw(isPrototype: true)
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
}
