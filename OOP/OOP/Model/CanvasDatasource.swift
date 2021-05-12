//
//  CanvasDatasource.swift
//  OOP
//
//  Created by Admin on 13.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class CanvasDatasource
{
    private(set) var shapes = [Shape]()
    private(set) var undoStack = [Shape]()
    

    var currentShape: Shape?
    
    func add(shape: Shape)  {
        shapes.append(shape)
    }
    
    func clear() {
        shapes.removeAll()
    }
    
    func undo() {
        if let shape = shapes.popLast()
        {
            undoStack.append(shape)
        }
    }
    func redo() {
        if let shape = undoStack.popLast(){
            shapes.append(shape)
        }
    }
    
    func resetUndoStack(){
        undoStack.removeAll()
    }

    func setShapes(shapes: [Shape]){
        self.shapes = shapes
        self.undoStack.removeAll()
    }
}
