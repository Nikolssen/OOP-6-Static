//
//  PenViewController.swift
//  OOP
//
//  Created by Admin on 12.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit

class PenViewController: UIViewController, Presentable {
    
    var options: DrawOptions!
    
    @IBOutlet weak var strokeWidthSlider: UISlider!
    @IBOutlet weak var strokeFillControl: UISegmentedControl!
    
    @IBOutlet weak var opacitySlider: UISlider!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var preview: Preview!
    
    let customTransitionDelegate = ModalDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 25
        self.preferredContentSize = CGSize(width: 375, height: 375)
        let rgb = options!.stroke.color.rgbDescription()
        redSlider.setValue(Float(rgb.red), animated: false)
        redLabel.text = "\(rgb.red)"
        greenSlider.setValue(Float(rgb.green), animated: false)
        greenLabel.text = "\(rgb.green)"
        blueSlider.setValue(Float(rgb.blue), animated: false)
        blueLabel.text = "\(rgb.blue)"
        let segmentTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LabelColorAsset")]
        strokeFillControl.setTitleTextAttributes(segmentTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        strokeWidthSlider.setValue(Float(options.stroke.width), animated: false)
        opacitySlider.setValue(Float(options.fill.opacity), animated: false)
        preview.options = options
        
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        let red = Int(redSlider.value)
        let green = Int(greenSlider.value)
        let blue = Int(blueSlider.value)
        
        if sender.isEqual(redSlider)
        {
            redLabel.text = "\(red)"
        }
        else if sender.isEqual(greenSlider){
            greenLabel.text = "\(green)"
        }
        else if sender.isEqual(blueSlider){
            blueLabel.text = "\(blue)"
        }
        
        if strokeFillControl.selectedSegmentIndex == 0
        {
            options.stroke.setColor(UIColor(red: red, green: green, blue: blue))
        }
        else
        {
            options.fill.setColor(UIColor(red: red, green: green, blue: blue))
        }
        
        preview.setNeedsDisplay()
    }
    
    @IBAction func widthSliderValueChanged(_ sender: UISlider) {
        options.stroke.setWidth(Int(sender.value))
        preview.setNeedsDisplay()
    }
    
    @IBAction func opacitySliderValueChanged(_ sender: UISlider) {
        options.fill.setOpacity(CGFloat(sender.value))
        preview.setNeedsDisplay()
    }
    
    
    @IBAction func typeSwitched(_ sender: UISegmentedControl) {
        let type = sender.selectedSegmentIndex == 0 ? options.stroke.color : options.fill.color
        let rgb = type.rgbDescription()
        
        redSlider.setValue(Float(rgb.red), animated: true)
        redLabel.text = "\(rgb.red)"
        greenSlider.setValue(Float(rgb.green), animated: true)
        greenLabel.text = "\(rgb.green)"
        blueSlider.setValue(Float(rgb.blue), animated: true)
        blueLabel.text = "\(rgb.blue)"
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    @IBAction func swipedDown(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}

