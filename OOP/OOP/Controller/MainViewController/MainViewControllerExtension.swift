//
//  MainViewControllerExtension.swift
//  OOP
//
//  Created by Admin on 07.04.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
extension MainViewController: SaveControllerDelegate{
 
    func viewToBeSavedToGalleryForSaveController(_ saveVC: SaveController) -> UIView?{
        return canvas
    }
    func dataToBeSavedForSaveController(_ saveVC: SaveController, in format: SaveController.SaveMethod) -> Data?{
        switch format {
        case .json:
            let encoder = JSONEncoder()
            let shapeWrapper = ShapeArrayCoder(shapes: canvasDatasource.shapes)
            guard let data = try? encoder.encode(shapeWrapper) else {return nil}
            return data
        case .plist:
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let shapeWrapper = ShapeArrayCoder(shapes: canvasDatasource.shapes)
            guard let data = try? encoder.encode(shapeWrapper) else {return nil}
            return data
        default:
            return nil
        }
       
    }
    
}

extension MainViewController: LoadViewControllerDelegate{
    func loadViewController(_ loadViewController: LoadViewController, load data: Data, from format: LoadViewController.Format) {
        var shapeWrapper: ShapeArrayCoder? = nil
        switch format {
        case .json:
            let decoder = JSONDecoder()
             shapeWrapper = try? decoder.decode(ShapeArrayCoder.self, from: data)
            
        case .plist:
            let decoder = PropertyListDecoder()
            shapeWrapper = try? decoder.decode(ShapeArrayCoder.self, from: data)
        }

        if shapeWrapper?.shapes != nil{
            canvasDatasource.setShapes(shapes: shapeWrapper!.shapes!)
                redoButton.isEnabled = false
                undoButton.isEnabled = !shapeWrapper!.shapes!.isEmpty
                canvas.setNeedsDisplay()
            }
    }

}
