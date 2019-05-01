//
//  UserLocation.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 3.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation: Codable {

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    let latitude: Double
    let longitude: Double
    let date: Date
    let dateString: String
    let description: String
    
    
    init(_ location: CLLocationCoordinate2D, date: Date, descriptionString: String) {
        latitude =  location.latitude
        longitude =  location.longitude
        self.date = date
        dateString = UserLocation.dateFormatter.string(from: date)
        description = descriptionString
    }
    
    convenience init(visit: CLVisit, descriptionString: String) {
         self.init(visit.coordinate, date: visit.arrivalDate, descriptionString: descriptionString)
    }
}


