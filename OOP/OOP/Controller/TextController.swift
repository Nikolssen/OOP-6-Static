//
//  TextController.swift
//  OOP
//
//  Created by Admin on 09.04.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit

class TextController: UIViewController {

    var textView: UITextView!
    var str: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView(frame: .zero)
        view.addSubview(textView)
        textView.textColor = UIColor(named: "LabelColorAsset")
        textView.text = str
        str = nil
        textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = .left
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor), textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), textView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        if let nav = navigationController{
            textView.contentOffset = CGPoint(x: 0, y: -nav.navigationBar.frame.height)
        }

        
    }
    override func viewDidAppear(_ animated: Bool) {
        view.setNeedsLayout()
    }
    
    convenience init(str: String){
        self.init()
        self.str = str
  
    }
    
}
