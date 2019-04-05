//
//  LocationDetailViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 6.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit



class LocationDetailViewController: BaseViewController {
    
    var location: Location?
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.backgroundColor = UIColor.navigationBarColor
        if location != nil {
            nameLabel.text = location?.locationType?.displayText
        }
        configureTableView()
    }

    private func configureTableView(){
        let detailNib = UINib(nibName: "DetailsTableViewCell", bundle: nil)
        detailTableView.register(detailNib, forCellReuseIdentifier: "DetailsTableViewCell")
        let mapNib = UINib(nibName: "MapTableViewCell", bundle: nil)
        detailTableView.register(mapNib, forCellReuseIdentifier: "MapTableViewCell")
        detailTableView.delegate = self
        detailTableView.dataSource = self
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
        let selectedTag = 0
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
            return tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
        }
    }
    
}
