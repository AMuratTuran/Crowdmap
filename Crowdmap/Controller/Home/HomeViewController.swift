//
//  HomeViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//
import UIKit
import Firebase

enum CampusType{
    case WestCampus
    case MainCampus
    
    static var numberOfSections = 5
}

enum LocationType{
    
    case library
    case gym
    case diningHall
    case ice
    case nero
    
    var text: String {
        switch self {
        case .library: return "Suna Kıraç Library"
        case .gym: return "Main Campus Gym"
        case .ice: return "Ice Rink"
        case .diningHall: return "Dining Hall"
        case .nero: return "Caffe Nero"
        }
        
    }
    
    var image: UIImage? {
        switch self {
        case .library: return UIImage(named: "Library")
        case .gym: return UIImage(named: "Gym")
        case .ice: return UIImage(named: "ice")
        case .diningHall: return UIImage(named: "diningHall")
        case .nero: return UIImage(named: "nero")
        }
    }
    
    static var numberOfLocations = 5
}

struct Section {
    var type: CampusType
    var locations: [LocationType]
}

class HomeViewController: UIViewController {
    
    var sections = [Section]()
    
    @IBOutlet weak var locationsTableView: UITableView!
    var data = [LocationType : [String:UIImage]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        sections = [
            Section(type: .MainCampus, locations: [.library, .gym, .ice, .diningHall, .nero]),
            Section(type: .WestCampus, locations: [.gym, .diningHall])
        ]
        
    }
    
    private func configureTableView(){
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        locationsTableView.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
    }
    
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -3.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)
            ] as [NSAttributedString.Key : Any]
        
        switch sections[indexPath.section].locations[indexPath.row] {
        case .gym:
            cell.locationNameLabel.attributedText = NSAttributedString(string: LocationType.gym.text, attributes: strokeTextAttributes)
            cell.locationImageView.image = LocationType.gym.image
        case .library:
            cell.locationNameLabel.attributedText = NSAttributedString(string: LocationType.library.text, attributes: strokeTextAttributes)
            cell.locationImageView.image = LocationType.library.image
        case .ice:
            cell.locationNameLabel.attributedText = NSAttributedString(string: LocationType.ice.text, attributes: strokeTextAttributes)
            cell.locationImageView.image = LocationType.ice.image
        case .nero:
            cell.locationNameLabel.attributedText = NSAttributedString(string: LocationType.nero.text, attributes: strokeTextAttributes)
            cell.locationImageView.image = LocationType.nero.image
        case .diningHall:
            cell.locationImageView.image = LocationType.diningHall.image
            cell.locationNameLabel.attributedText = NSAttributedString(string: LocationType.diningHall.text, attributes: strokeTextAttributes)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section].type {
        case .MainCampus:
            return "Main Campus"
        case .WestCampus:
            return "West Campus"
        }
    }
}

