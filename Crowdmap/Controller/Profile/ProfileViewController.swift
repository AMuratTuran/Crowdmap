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
    @IBOutlet weak var favoritesView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        configureProfilePage()
        email = Auth.auth().currentUser?.email
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    private func configureProfilePage() {
        topView.backgroundColor = UIColor.navigationBarColor
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width/2
        profilePictureView.clipsToBounds = true
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 5.0
        profilePictureView.image = UIImage(named: "pp")
        nameLabel.text = "\(User.user.name!) \(User.user.lastName!)"
        
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
//
//        let docRef = db.collection("users").document(email!)
//
//        docRef.getDocument { (document, error) in
//            if let user = document.flatMap({
//                $0.data().flatMap({ (data) -> User in
//                    guard let last = data["last"] as? String else { return User.user }
//                    User.user.lastName = last
//                    User.user.name = data["first"] as? String
//                    User.user.email = data["email"] as? String
//                    return User.user
//                })
//            }) {
//                print("User: \(user)")
//            } else {
//                print("Document does not exist")
//            }
//        }
        
        let favs = User.user.favPlaces
        var y = 0
        favs.forEach { (locationName) in
            let building = getBuilding(locationName)
            let locationType = building?.locationType!
            var ringValue = CGFloat(((building?.numberOfPeople!)! * 100) / (building?.locationType!.capacity)!)
            if  locationType == .libraryfirst || locationType == .libraryzero || locationType == .libraryminus || locationType == .librarytwentyfour || locationType == .librarysecond || locationType == .neroSC {
                ringValue = ringValue * 0.7
            }
            let label = UILabel(frame: CGRect(x: 15, y: y, width: 360, height: 21))
            label.textAlignment = .left
            label.text = "\(locationName) - Crowdedness: \(Int(ringValue))%"
            label.textColor = UIColor.white
            favoritesView.addSubview(label)
            y += 21
        }

    }

}

func getBuilding(_ name: String) -> Buildings? {
    var returnValue:Buildings?
    HomeViewController.globalBuildings.forEach { (globalBuilding) in
        if globalBuilding.locationType?.displayText == name {
            returnValue = globalBuilding
        }
    }
    return returnValue
}
