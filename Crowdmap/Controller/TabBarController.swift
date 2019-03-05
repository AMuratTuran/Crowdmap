//
//  TabBarController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//


import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    
    func setupTabBar() {
        tabBar.barStyle = .black
        tabBar.barTintColor = UIColor.white
        tabBar.tintColor = UIColor.kuRadarTabBarIcon
        tabBar.isTranslucent = false
        tabBar.layer.borderColor = UIColor.clear.cgColor
        tabBar.layer.borderWidth = 0
        tabBar.layer.masksToBounds = false
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3
    }
}
