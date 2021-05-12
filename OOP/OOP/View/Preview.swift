//
//  Preview.swift
//  OOP
//
//  Created by Admin on 12.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class Preview: UIView {
    
    var options: DrawOptions!
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: CGRect(x: 25, y: 25, width: 50, height: 50))
        path.lineWidth = CGFloat(options.stroke.width)
        options.stroke.color.setStroke()
        options.fill.color.setFill()
        path.fill(with: CGBlendMode.normal, alpha: options.fill.opacity)
        path.stroke()
        
    }
    
    
}
