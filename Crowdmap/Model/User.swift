//
//  User.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 9.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import UIKit

enum Gender {
    case male
    case female
    case none
}

class User{
    
    static let user = User()
    
    var name: String!
    var lastName: String!
    var password: String!
    var email: String!
    var profilePicture: UIImage?
    var school: String = "Koç University"
    var major: String? = "-"
    var gender: Gender?
    var isVerified: Bool = false
    var favPlaces : [String] = []

    init(){
        if gender == Gender.male {
            self.profilePicture = UIImage(named: "DefaultProfilePictureMale")
        }else if gender == Gender.female {
            self.profilePicture = UIImage(named: "DefaultProfilePictureFemale")
        }else {
            self.profilePicture = UIImage(named: "DefaultProfilePictureMale")
        }
    }
}
