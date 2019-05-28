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
    
    var db : Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let user = Auth.auth().currentUser
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if user != nil && (user?.isEmailVerified)! {
            let docRef = db.collection("users").document((user?.email)!)
            docRef.getDocument { (document, error) in
                if let user = document.flatMap({
                    $0.data().flatMap({ (data) -> User in
                        guard let last = data["last"] as? String else { return User.user }
                        User.user.lastName = last
                        User.user.name = data["first"] as? String
                        User.user.email = data["email"] as? String
                        User.user.favPlaces = (data["favPlaces"] as? [String])!
                        return User.user
                    })
                }) {
                    print("User: \(user.favPlaces)")
                } else {
                    print("Document does not exist")
                }
            }
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "TabBarController")
            self.present(nextVC, animated: true, completion: nil)
        }else if user?.isEmailVerified == false {
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(nextVC, animated: true, completion: nil)
        }
    }
    
    
    
}
