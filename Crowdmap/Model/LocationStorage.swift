//
//  LocationStorage.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 13.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//


import Foundation
import CoreLocation

class LocationsStorage {
    static let shared = LocationsStorage()
    
    private(set) var locations: [UserLocation]
    private let fileManager: FileManager
    private let documentsURL: URL
    
    init() {
        let fileManager = FileManager.default
        documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        self.fileManager = fileManager
        
        let jsonDecoder = JSONDecoder()
        
        let locationFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL,
                                                                     includingPropertiesForKeys: nil)
        locations = locationFilesURLs.compactMap { url -> UserLocation? in
            guard !url.absoluteString.contains(".DS_Store") else {
                return nil
            }
            guard let data = try? Data(contentsOf: url) else {
                return nil
            }
            return try? jsonDecoder.decode(UserLocation.self, from: data)
            }.sorted(by: { $0.date < $1.date })
    }
    
    func saveLocationOnDisk(_ location: UserLocation) {
        let encoder = JSONEncoder()
        let timestamp = location.date.timeIntervalSince1970
        let fileURL = documentsURL.appendingPathComponent("\(timestamp)")
        
        let data = try! encoder.encode(location)
        try! data.write(to: fileURL)
        
        locations.append(location)
        
        NotificationCenter.default.post(name: .newLocationSaved, object: self, userInfo: ["location": location])
    }
    
    func saveCLLocationToDisk(_ clLocation: CLLocation) {
        let currentDate = Date()
        AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
            if let place = placemarks?.first {
                let location = UserLocation(clLocation.coordinate, date: currentDate, descriptionString: "\(place)")
                self.saveLocationOnDisk(location)
            }
        }
    }
}

extension Notification.Name {
    static let newLocationSaved = Notification.Name("newLocationSaved")
}


