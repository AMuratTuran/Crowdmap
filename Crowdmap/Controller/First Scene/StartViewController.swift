//
//  StartViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Firebase
import RAMAnimatedTabBarController

class StartViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if user != nil && (user?.isEmailVerified)! {
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
            self.present(nextVC, animated: true, completion: nil)
        }else if user?.isEmailVerified == false {
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    
    
}
