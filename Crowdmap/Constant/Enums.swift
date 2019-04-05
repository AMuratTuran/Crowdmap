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
        }
    }
    
    var capacity: Int {
        switch self {
        case .libraryminus: return 300
        case .libraryzero: return 250
        case .libraryfirst: return 300
        case .librarysecond: return 300
        case .librarytwentyfour: return 300
        case .gym: return 300
        case .neroCAS: return 100
        case .neroSC: return 200
        case .ice: return 150
        case .foodCourt: return 250
        case .yemekhane: return 250
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
        }
    }
}
