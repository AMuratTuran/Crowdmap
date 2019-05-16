//
//  ProfileViewController.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 9.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.

import UIKit
import Firebase
import RAMAnimatedTabBarController

class ProfileViewController: BaseViewController {
    
    var ref: DatabaseReference!
    
    var db : Firestore!
    
    var email : String?
    var name : String?
    var lastName : String?

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        configureProfilePage()
        email = Auth.auth().currentUser?.email
        getUserInfo()
    }
    
    private func configureProfilePage() {
        topView.backgroundColor = UIColor.navigationBarColor
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width/2
        profilePictureView.clipsToBounds = true
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 5.0
        profilePictureView.image = UIImage(named: "pp")
    }
    
    func getUserInfo(){
//        db.collection("users").whereField("email", isEqualTo: email).addSnapshotListener{ snapshot, error in
//            guard let snapshot = snapshot else {
//                print("Error retreiving snapshots \(error!)")
//                return
//            }
//            let userData = snapshot.documents[0].data()
//            for (key, value) in userData{
//                print("====== \(value) ======")
//            }
//        }
        
        let docRef = db.collection("users").document(email!)
        
        docRef.getDocument { (document, error) in
            if let user = document.flatMap({
                $0.data().flatMap({ (data) -> User in
                    guard let last = data["last"] as? String else { return User.user }
                    User.user.lastName = last
                    User.user.name = data["first"] as? String
                    User.user.email = data["email"] as? String
                    print("===== \(User.user.email) =============")
                    return User.user
                })
            }) {
                print("User: \(user)")
            } else {
                print("Document does not exist")
            }
        }
    }

}
struct City {
    
    let last: String
    let first: String?
    let email: String?
    
    init?(dictionary: [String: Any]) {
        guard let last = dictionary["last"] as? String else { return nil }
        self.last = last
        
        self.first = dictionary["first"] as? String
        self.email = dictionary["email"] as? String
    }
    
}
