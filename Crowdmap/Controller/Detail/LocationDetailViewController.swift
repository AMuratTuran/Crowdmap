//
//  LocationDetailViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 6.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit



class LocationDetailViewController: BaseViewController {
    
    var location: Buildings?
    var groupedAPs: [[Buildings]] = []
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var segmentedControl: UIStackView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    var selectedTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.backgroundColor = UIColor.navigationBarColor
        if location != nil {
            nameLabel.text = location?.locationType?.displayText
        }
        configureTableView()
        configureSegmentedControl()
    }
    
    private func configureSegmentedControl(){
        if location?.locationType != .librarysecond && location?.locationType != .librarytwentyfour {
            mapButton.removeFromSuperview()
        }
    }

    private func configureTableView(){
        let detailNib = UINib(nibName: "DetailsTableViewCell", bundle: nil)
        detailTableView.register(detailNib, forCellReuseIdentifier: "DetailsTableViewCell")
        
        let mapNib = UINib(nibName: "MapTableViewCell", bundle: nil)
        detailTableView.register(mapNib, forCellReuseIdentifier: "MapTableViewCell")
        
        let mapTwentyNib = UINib(nibName: "LibraryTwentyFourTableViewCell", bundle: nil)
        detailTableView.register(mapTwentyNib, forCellReuseIdentifier: "LibraryTwentyFourTableViewCell")
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
  
    @IBAction func detailButtonTapped(_ sender: UIButton) {
        selectedTag = 0
        detailTableView.reloadData()
    }
    @IBAction func mapButtonTapped(_ sender: UIButton) {
        selectedTag = 1
        detailTableView.reloadData()
    }
    @IBAction func historyButtonTapped(_ sender: UIButton) {
        selectedTag = 2
        detailTableView.reloadData()
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension LocationDetailViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch selectedTag {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.configureCell(location: location!)
            return cell
//        case 1:
//            return  tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
//        case 2:
//            return tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
        default:
            if location?.locationType == .librarytwentyfour {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryTwentyFourTableViewCell", for: indexPath) as! LibraryTwentyFourTableViewCell
                cell.groupedAPs = groupedAPs
                cell.assignPulsators()
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
                cell.location = self.location
                cell.groupedAPs = groupedAPs
                cell.assignPulsators()
                return cell
            }
        }
    }
    
}
