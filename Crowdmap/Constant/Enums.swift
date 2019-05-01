//
//  Enums.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 3.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationType: String{
    case gym
    case foodCourt
    case yemekhane
    case ice
    case neroCAS
    case neroSC
    case libraryminus
    case libraryzero
    case libraryfirst
    case librarysecond
    case librarytwentyfour
    case error
    
    var displayText: String {
        switch self {
        case .libraryminus: return "Suna Kıraç Library -1"
        case .libraryzero: return "Suna Kıraç Library 0"
        case .libraryfirst: return "Suna Kıraç Library 1"
        case .librarysecond: return "Suna Kıraç Library 2"
        case .librarytwentyfour: return "Suna Kıraç Library 7/24"
        case .gym: return "Gym"
        case .ice: return "Ice Rink"
        case .foodCourt: return "Student Center"
        case .yemekhane: return "Yemekhane"
        case .neroSC: return "Nero Student Center"
        case .neroCAS: return "Nero CAS"
        case .error: return "Error"
        }
    }
    
    var text: String {
        switch self {
        case .libraryminus: return "Library -1"
        case .libraryzero: return "Library 0"
        case .libraryfirst: return "Library 1"
        case .librarysecond: return "Library 2"
        case .librarytwentyfour: return "Library 24/7"
        case .gym: return "Gym"
        case .neroCAS: return "Nero CAS"
        case .neroSC: return "Nero Student Center"
        case .ice: return "Ice"
        case .foodCourt: return "Food Court"
        case .yemekhane: return "Yemekhane"
        case .error: return "Error"
        }
    }
    
    var capacity: Int {
        switch self {
        case .libraryminus: return 80
        case .libraryzero: return 80
        case .libraryfirst: return 150
        case .librarysecond: return 350 // değişebilir.
        case .librarytwentyfour: return 120
        case .gym: return 200
        case .neroCAS: return 100
        case .neroSC: return 150
        case .ice: return 50
        case .foodCourt: return 300
        case .yemekhane: return 250
        case .error: return 1
        }
    }
    
    var image: UIImage {
        switch self {
        case .libraryminus: return UIImage(named: "Lib")!
        case .libraryzero: return UIImage(named: "Lib")!
        case .libraryfirst: return UIImage(named: "Lib")!
        case .librarysecond: return UIImage(named: "Lib")!
        case .librarytwentyfour: return UIImage(named: "Lib")!
        case .gym: return UIImage(named: "Gym")!
        case .neroCAS: return UIImage(named: "Nero")!
        case .neroSC: return UIImage(named: "Nero")!
        case .ice: return UIImage(named: "Ice")!
        case .foodCourt: return UIImage(named: "Ömer")!
        case .yemekhane: return UIImage(named: "Yemekhane")!
        case .error: return UIImage()
        }
    }
    
    var coordinates: CLLocation {
        switch self {
        case .libraryminus: return CLLocation(latitude: 41.2059, longitude: 29.0734)
        case .libraryzero: return CLLocation(latitude: 41.2059, longitude: 29.0734)
        case .libraryfirst: return CLLocation(latitude: 41.2059, longitude: 29.0734)
        case .librarysecond: return CLLocation(latitude: 41.2059, longitude: 29.0734)
        case .librarytwentyfour: return CLLocation(latitude: 41.2059, longitude: 29.0734)
        case .gym: return CLLocation(latitude: 41.2073, longitude: 29.0724)
        case .neroCAS: return CLLocation(latitude: 41.2058, longitude: 29.0743)
        case .neroSC: return CLLocation(latitude: 41.2047, longitude: 29.0738)
        case .ice: return CLLocation(latitude: 41.2066, longitude: 29.0717)
        case .foodCourt: return CLLocation(latitude: 41.2049, longitude: 29.0732)
        case .yemekhane: return CLLocation(latitude: 41.2049, longitude: 29.0732)
        case .error: return CLLocation(latitude: 0.0, longitude: 0.0)
        }
    }
}

enum detailedLibrary {
//    case LibraryMinusMiddle
//    case LibraryMinusRight
//    case LibraryMinusLeft
//
    case LibraryTwentyFourMiddle
    case LibraryTwentyFourFront
    case LibraryTwentyFourBack
//
//    case LibraryZeroMiddle
//
//    case LibraryFirstFrontMiddle
//    case LibraryFirstLeftFront
//    case LibraryFirstRightFront
//    case LibraryFirstLeftMiddle
//    case LibraryFirstRightMiddle
//    case LibraryFirstRightBack
    
    case LibrarySecondRightMiddle
    case LibrarySecondRight
    case LibrarySecondLeft
    case LibrarySecondRightFront
    case LibrarySecondLeftMiddle
    case LibrarySecondLeftFront
    case LibrarySecondFrontMiddle
    case LibrarySecondLeftBack
    case LibrarySecondRightBack
    case error
    
    var capacity: Int {
        switch self {
//        case .LibraryMinusMiddle: return 300
//        case .LibraryMinusRight: return 300
//        case .LibraryMinusLeft: return 300
//
        case .LibraryTwentyFourMiddle: return 40
        case .LibraryTwentyFourFront: return 40
        case .LibraryTwentyFourBack: return 40
//
//        case .LibraryZeroMiddle: return 300
//
//        case .LibraryFirstFrontMiddle: return 300
//        case .LibraryFirstLeftFront: return 300
//        case .LibraryFirstRightFront: return 300
//        case .LibraryFirstLeftMiddle: return 300
//        case .LibraryFirstRightMiddle: return 300
//        case .LibraryFirstRightBack: return 300
//
        case .LibrarySecondRightMiddle: return 45
        case .LibrarySecondRight: return 45
        case .LibrarySecondLeft: return 45
        case .LibrarySecondRightFront: return 30
        case .LibrarySecondLeftMiddle: return 45
        case .LibrarySecondLeftFront: return 45
        case .LibrarySecondFrontMiddle: return 45
        case .LibrarySecondLeftBack: return 25
        case .LibrarySecondRightBack: return 25
            
        case .error: return 1
            
        }
    }
}
