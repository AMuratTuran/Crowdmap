//
//  HomeViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//
import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import FoldingCell
import ChameleonFramework
import RAMAnimatedTabBarController
import CoreLocation
import UserNotifications

class HomeViewController: BaseViewController {
    
    enum Const {
        static let closeCellHeight: CGFloat = 120
        static let openCellHeight: CGFloat = 240
        static let rowsCount = 11
    }
    
    var locations: [Location] = []
    var cellHeights: [CGFloat] = []
    var progressBarValues: [CGFloat] = []
    var values: [CGFloat] = []
    var currentTime = Date()
    let refreshControl = UIRefreshControl()
    let locationManager = CLLocationManager()
    let center = UNUserNotificationCenter.current()
    var coordinates: CLLocationCoordinate2D?
    let notificationManager = NotificationManager()
    
    @IBOutlet weak var foldingTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureHomeScreen()
        configureTableView()
        configureRefreshControl()
        configureLocationServices()
    }
    
    @objc func reloadData() {
        getData()
    }
    @objc func detailButtonPressed(sender: UIButton){
        let storyboard : UIStoryboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let vc : LocationDetailViewController = storyboard.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
        vc.location = locations[sender.tag]
        self.present(vc, animated: true, completion: nil)
    }
    private func configureLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    func calculateDistance(){
//        let loc = CLLocation(latitude: coordinates!.latitude, longitude: coordinates!.longitude)
//        let distanceInMeters = loc.distance(from: LocationType.foodCourt.coordinates)
//        print(distanceInMeters)
    }
    private func  configureRefreshControl(){
        refreshControl.addTarget(self, action:  #selector(reloadData), for: .valueChanged)
        refreshControl.tintColor = UIColor.flatMint
        foldingTableView.addSubview(refreshControl)
    }
    private func configureHomeScreen(){
        foldingTableView.backgroundColor = UIColor.clear
        topView.backgroundColor = UIColor.navigationBarColor
    }
    private func configureTableView(){
        
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        progressBarValues = Array(repeating: 0.0, count: 11)
        values = Array(repeating: 0.0, count: 11)
        
        //MARK: Register nib
        let nib = UINib(nibName: "FoldingTableViewCell", bundle: nil)
        foldingTableView.register(nib, forCellReuseIdentifier: "FoldingTableViewCell")
        
        foldingTableView.delegate = self
        foldingTableView.dataSource = self
        foldingTableView.estimatedRowHeight = Const.closeCellHeight
        foldingTableView.rowHeight = UITableView.automaticDimension
        foldingTableView.separatorStyle = .none
    }
    private func getData(){
        let url: String = "https://pingit.denizdaum.de/AppAPI.php/AxsH2E8HxOCodX"
        Alamofire.request(url)
            .responseData { response in
                guard let data = response.result.value else {
                    print("Error: No data to decode")
                    return
                }
                guard let allLocations = try? JSONDecoder().decode([Location].self, from: data) else {
                    print("Error: Couldn't decode data into Blog")
                    return
                }
                self.locations = allLocations
                self.refreshControl.endRefreshing()
                self.foldingTableView.reloadData()
                self.calculateDistance()
        }
    }
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as FoldingTableViewCell = cell else {return}
        cell.backgroundColor = .clear
        if values[indexPath.row] == 0{
            DispatchQueue.main.async {
                cell.progressRing.startProgress(to: self.progressBarValues[indexPath.row] , duration: 1)
            }
            values[indexPath.row] = progressBarValues[indexPath.row]
        }else{
            cell.progressRing.startProgress(to: self.progressBarValues[indexPath.row] , duration: 0)
        }
        
        if  cell.progressRing.value != progressBarValues[indexPath.row] && indexPath.row > 4 {
            cell.progressRing.startProgress(to: self.progressBarValues[indexPath.row] , duration: 0)
        }
        cell.detailProgressRing.value = self.progressBarValues[indexPath.row]
        
        
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingTableViewCell", for: indexPath) as! FoldingTableViewCell
    var currentLocation = locations[indexPath.row]
    
    displayCell(currentLocation: &currentLocation, cell: cell, indexPath: indexPath)
    let durations: [TimeInterval] = [0.1, 0.1, 0.1]
    cell.durationsForExpandedState = durations
    cell.durationsForCollapsedState = durations
    
   
    return cell
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
        NotificationManager().scheduleNotification(notificationType: "Notification Test")
    }
}

extension HomeViewController {
    
    private func displayCell(currentLocation: inout Location, cell: FoldingTableViewCell, indexPath: IndexPath ){
        
        cell.updateCell(location: &currentLocation)
        locations[indexPath.row] = currentLocation
        if progressBarValues[indexPath.row] == 0 {
            progressBarValues[indexPath.row] = currentLocation.ringValue!
        }
        cell.detailsButton.tag = indexPath.row
        cell.detailsButton.addTarget(self, action: #selector(detailButtonPressed(sender: )), for: .touchUpInside)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        coordinates = locValue
    }
}
