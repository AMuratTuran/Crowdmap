//
//  BaseViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import MBProgressHUD
import AMScrollingNavbar
import Bartinter

class BaseViewController: ScrollingNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        addBackground()
        self.view.backgroundColor = UIColor.mainBackgroundColor
        self.tabBarController?.tabBar.barTintColor = UIColor.navigationBarColor
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor
        updatesStatusBarAppearanceAutomatically = true
    }
    
    
    func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
//    func addBackground() {
//        // screen width and height:
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
//
//        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        imageViewBackground.image = UIImage(named: "mainBackground")
//
//        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill
//
//        self.view.addSubview(imageViewBackground)
//        self.view.sendSubviewToBack(imageViewBackground)
//    }
}
