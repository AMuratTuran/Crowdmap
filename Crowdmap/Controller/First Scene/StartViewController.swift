//
//  StartViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
        if user != nil && (user?.isEmailVerified)! {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }else if user?.isEmailVerified == false {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    
    
}
