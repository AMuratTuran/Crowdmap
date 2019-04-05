//
//  LocationDetailViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 6.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit

protocol SegmentActionDelegate {
    func segmentChanged(segmentIndex: Int)
}

class LocationDetailViewController: BaseViewController {
    
    var location: Location?
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segmentControl: CustomSegmentControl!
    var segmentDelegate: SegmentActionDelegate!
    var selectedSegmentIndex: Int = 0
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBar.backgroundColor = UIColor.navigationBarColor
        setupSegmentControl()
        self.segmentDelegate = self
        if location != nil {
            nameLabel.text = location?.locationType?.displayText
        }
        configureTableView()
    }
    
    @IBAction func segmentChanged(_ sender: CustomSegmentControl) {
        segmentDelegate.segmentChanged(segmentIndex: sender.selectedSegmentIndex)
    }
    
    private func configureTableView(){
        let detailNib = UINib(nibName: "DetailsTableViewCell", bundle: nil)
        detailTableView.register(detailNib, forCellReuseIdentifier: "DetailsTableViewCell")
        let mapNib = UINib(nibName: "MapTableViewCell", bundle: nil)
        detailTableView.register(mapNib, forCellReuseIdentifier: "MapTableViewCell")
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    private func setupSegmentControl() {
        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Details", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Map", at: 1, animated: false)
        segmentControl.insertSegment(withTitle: "History", at: 2, animated: false)
        segmentControl.selectedSegmentIndex = 0
    }
    
    @IBAction func dismissPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LocationDetailViewController: SegmentActionDelegate{
    func segmentChanged(segmentIndex: Int) {
        selectedSegmentIndex = segmentIndex
        detailTableView.reloadData()
        
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
        switch selectedSegmentIndex {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
            cell.configureCell(location: location!)
            return cell
        case 1:
            return  tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
        case 2:
            return tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
        default:
            return tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath)
        }
    }
    
}
