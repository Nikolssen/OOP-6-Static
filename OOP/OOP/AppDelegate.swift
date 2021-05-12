//
//  AppDelegate.swift
//  OOP
//
//  Created by Admin on 28.02.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit
import Shape

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainWindow = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let rootViewController = UINavigationController(rootViewController: mainVC)
        rootViewController.navigationBar.tintColor = UIColor(red: 255, green: 144, blue: 45)
        rootViewController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "LabelColorAsset")!]
        mainWindow.rootViewController = rootViewController
        rootViewController.navigationBar.alpha = 1.0
        rootViewController.navigationBar.backgroundColor = UIColor.white
        rootViewController.navigationBar.isHidden = true
        window = mainWindow
        window?.makeKeyAndVisible()
        
        return true
    }


}

