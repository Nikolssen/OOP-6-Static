//
//  LoadViewController.swift
//  OOP
//
//  Created by Admin on 09.04.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit

class LoadViewController: UITableViewController {
     
    var files = [String]()
    weak var delegate: LoadViewControllerDelegate?
    enum Format{
        case json
        case plist
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return files.count
        }
        func getDocumentsDirectory()->URL{
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FileCellID", for: indexPath) as! FileTableViewCell
          
            if files[indexPath.row].hasSuffix(".plist"){
                cell.formatLabel.text = "XML"
                cell.label.text = files[indexPath.row].replacingOccurrences(of: ".plist", with: "")
            }
            else if files[indexPath.row].hasSuffix(".json"){
                cell.formatLabel.text = "JSON"
                cell.label.text = files[indexPath.row].replacingOccurrences(of: ".json", with: "")
            }

            return cell
            
        }
            
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self] (ac: UIContextualAction, view: UIView, completion: ((Bool) -> Void)) in

                    guard let directory = self?.getDocumentsDirectory() else {return}
                    guard let fileName = self?.files[indexPath.row] else {return}
                    let url = directory.appendingPathComponent(fileName)
                    do
                    {
                        try FileManager.default.removeItem(at: url)
                        self?.files.remove(at: indexPath.row)
                        self?.tableView.deleteRows(at: [indexPath], with: .fade)
                        completion(true)

                    }
                catch{}
            })
            deleteAction.backgroundColor = UIColor.red
            return UISwipeActionsConfiguration(actions: [deleteAction])
        }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let rawPreviewAction = UIContextualAction(style: .destructive, title: "View Raw", handler: {[weak self] (ac: UIContextualAction, view: UIView, completion: ((Bool) -> Void)) in
                
                guard let directory = self?.getDocumentsDirectory() else {return}
                guard let fileName = self?.files[indexPath.row] else {return}
                let url = directory.appendingPathComponent(fileName)
                if let data = FileManager.default.contents(atPath: url.path) {
                    if let str = String(data: data, encoding: .utf8){
                        let textVC = TextController(str: str)
                        textVC.title = fileName
                        self?.navigationController?.pushViewController(textVC, animated: true)
                    }
                }
            })
            rawPreviewAction.backgroundColor = UIColor(red: 255, green: 144, blue: 45)
            return UISwipeActionsConfiguration(actions: [rawPreviewAction])
        }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let directory = self.getDocumentsDirectory()
        let fileName = self.files[indexPath.row]
        let url = directory.appendingPathComponent(fileName)
        if let data = FileManager.default.contents(atPath: url.path) {
            var format: Format? = nil
            if files[indexPath.row].hasSuffix(".plist"){
                format = .plist
            }
            else if files[indexPath.row].hasSuffix(".json"){
                format = .json
            }
            if format != nil{
                delegate?.loadViewController(self, load: data, from: format!)
                let _ = navigationController?.popViewController(animated: true)
            }

        }
    }
        override func viewDidLoad() {
            super.viewDidLoad()
            navigationController?.navigationBar.isHidden = false
            self.title = "Load File"
            tableView.register(UINib(nibName: "FileTableViewCell", bundle: nil), forCellReuseIdentifier: "FileCellID")
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            if let result = try? FileManager.default.contentsOfDirectory(atPath: paths[0].path){
                files = result
            }
        }
        override func viewWillAppear(_ animated: Bool) {
            navigationController?.navigationBar.isHidden = false
        }
        
    }

protocol LoadViewControllerDelegate: AnyObject {
    func loadViewController(_ loadViewController: LoadViewController,  load data: Data, from format: LoadViewController.Format)
}
