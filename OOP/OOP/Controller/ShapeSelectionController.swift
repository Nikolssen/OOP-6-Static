//
//  ShapeSelectionController.swift
//  OOP
//
//  Created by Admin on 13.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

class ShapeSelectionController: UITableViewController, Presentable {
    
    weak var options: ShapeOptions?
    var swipeGestureRecognizer: UISwipeGestureRecognizer!
    let customTransitionDelegate = ModalDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 25
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "shapeCell")
        self.tableView.isScrollEnabled = false
       
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown(sender:)))
        swipeGestureRecognizer.direction = .down
        self.tableView.addGestureRecognizer(swipeGestureRecognizer)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Header")

    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return "Shapes"
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShapeOptions.availableCreators.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
        view?.textLabel?.textColor = UIColor(named: "LabelColorAsset")
        return view

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shapeCell", for: indexPath)
        let textData = ShapeOptions.availableCreators[indexPath.row].shapeName()
        cell.textLabel?.textColor = UIColor(named: "LabelColorAsset")
        cell.textLabel?.text = textData
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options?.chooseShape(at: indexPath.row)
        dismiss(animated: true, completion: nil)
    }
    
    init() {
        super.init(style: .plain)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    
    @objc func swipedDown(sender: UISwipeGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
}

