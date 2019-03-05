//
//  NavController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//


import Foundation
import UIKit

class NavController: UINavigationController {
    
    
    enum FontType: String {
        case helveticaRegular = "Helvetica Neue"
        case helveticaBold = "HelveticaNeue-Bold"
        case catamaranRegular = "Catamaran"
        case catamaranBold = "Catamaran-Bold"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()    }
    
    
    private func setupNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.kuRadarNavigationBar
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
}
