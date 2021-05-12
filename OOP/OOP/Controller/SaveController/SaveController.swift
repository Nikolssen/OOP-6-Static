//
//  SaveController.swift
//  OOP
//
//  Created by Admin on 04.04.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit

class SaveController: UIViewController, Presentable{ //, UITextFieldDelegate {
    
    enum SaveMethod{
        case plist
        case json
        case gallery
    }

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var formatPicker: UISegmentedControl!
    
    private var method: SaveMethod = .json
    weak var delegate: SaveControllerDelegate?
    let customTransitionDelegate = ModalDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 25
        saveButton.layer.cornerRadius = 20
        let segmentTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LabelColorAsset")]
        formatPicker.setTitleTextAttributes(segmentTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        // Do any additional setup after loading the view.
    }

    func saveToGallery()  {
        if let view = delegate?.viewToBeSavedToGalleryForSaveController(self){
            let imageRenderer = UIGraphicsImageRenderer(size: view.bounds.size)
            let image = imageRenderer.image(actions: { ctx in
                view.draw(view.bounds)
            })
            DispatchQueue.global().async {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            dismiss(animated: true, completion: nil)
        }
    }
    func getDocumentsDirectory()->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getDateString() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.Y hh:mm:ss"
        return formatter.string(from: date)
    }

    func saveData() {
        if let data = delegate?.dataToBeSavedForSaveController(self, in: method){

            let fileExtension: String
            switch method {
            case .json:
                fileExtension = ".json"
            case .plist:
                fileExtension = ".plist"
            case .gallery:
                return
            }
            
            let fileName = getDateString()
            let url = getDocumentsDirectory().appendingPathComponent(fileName+fileExtension)
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil )
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func dismissAction(_ sender: UISwipeGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveAction(_ sender: UIButton) {
        switch method {
        case .gallery:
            saveToGallery()
        default:
            saveData()
        }
    }
    
    @IBAction func formatControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            method = .json
        case 1:
            method = .plist
        case 2:
            method = .gallery
        default:
            break
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

protocol SaveControllerDelegate: AnyObject{

    func viewToBeSavedToGalleryForSaveController(_ saveVC: SaveController) -> UIView?
    func dataToBeSavedForSaveController(_ saveVC: SaveController, in format:SaveController.SaveMethod) -> Data?
}


