//
//  AppDelegate.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let geoCoder = CLGeocoder()
    let locationManager = CLLocationManager()
    let notificationManager = NotificationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
    //    locationManager.requestAlwaysAuthorization()
  //      locationManager.requestWhenInUseAuthorization()
        notificationManager.notificationCenter.delegate = notificationManager
    //    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
     //   locationManager.startUpdatingLocation()
        notificationManager.notificationRequest()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

