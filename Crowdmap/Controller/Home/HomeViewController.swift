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
        static let headerViewMaxHeight: CGFloat = 175
        static let headerViewMinHeight: CGFloat = 0
    }
    
    var locations: [Buildings] = []
    var groupedLocations: [Buildings] = []
    var cellHeights: [CGFloat] = []
    var progressBarValues: [CGFloat] = []
    var values: [CGFloat] = []
    var libraryZeroAPs:[Buildings] = []
    var cumulativeLibraryZero:Buildings = Buildings()
    var libraryMinusAPs:[Buildings] = []
    var cumulativeLibraryMinus:Buildings = Buildings()
    var libraryTwentyfourAPs:[Buildings] = []
    var cumulativeLibraryTwentyFour:Buildings = Buildings()
    var librarySecondAPs:[Buildings] = []
    var cumulativeLibrarySecond:Buildings = Buildings()
    var libraryFirstAPs:[Buildings] = []
    var cumulativeLibraryFirst:Buildings = Buildings()
    var gymAPs:[Buildings] = []
    var cumulativeGym:Buildings = Buildings()
    var yemekhaneAPs:[Buildings] = []
    var cumulativeYemekhane:Buildings = Buildings()
    var iceAPs:[Buildings] = []
    var cumulativeIce:Buildings = Buildings()
    var neroSCAPs:[Buildings] = []
    var cumulativeNeroSC:Buildings = Buildings()
    var neroCASAPs:[Buildings] = []
    var cumulativeNeroCAS:Buildings = Buildings()
    var studentCenterAPs:[Buildings] = []
    var cumulativeStudentCenter:Buildings = Buildings()
    var currentTime = Date()
    let refreshControl = UIRefreshControl()
    let locationManager = CLLocationManager()
    var groupedAps: [[Buildings]] = []
    
    @IBOutlet weak var foldingTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var headerMaxViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var BasedOnLocationLabel: UILabel!
    @IBOutlet weak var closestLocationLabel: UILabel!
    @IBOutlet weak var bestPlaceToStudyLabel: UILabel!
    @IBOutlet weak var bestPlaceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configureHomeScreen()
        configureTableView()
        configureRefreshControl()
        configureLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
    }
    @objc func reloadData() {
        getData()
    }
    @objc func detailButtonPressed(sender: UIButton){
        
        
        let storyboard : UIStoryboard = UIStoryboard(name: "LocationDetail", bundle: nil)
        let vc : LocationDetailViewController = storyboard.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
        vc.location = groupedLocations[sender.tag]
        vc.groupedAPs = groupedAps
        self.present(vc, animated: true, completion: nil)
    }
    private func configureLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestLocation()
        }
    }
    private func configureRefreshControl(){
        refreshControl.addTarget(self, action:  #selector(reloadData), for: .valueChanged)
        refreshControl.tintColor = UIColor.flatMint
        foldingTableView.addSubview(refreshControl)
    }
    private func configureHomeScreen(){
        foldingTableView.backgroundColor = UIColor.clear
        topView.backgroundColor = UIColor.navigationBarColor
        headerView.backgroundColor = UIColor.mainCellColor
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
        // let url: String = "https://pingit.denizdaum.de/AppAPI.php/AxsH2E8HxOCodX"
        let url: String = "https://pingit.denizdaum.de/AppAPI.php/ETV2bKtYbrNmoArK5w"
        Alamofire.request(url)
            .responseData { response in
                guard let data = response.result.value else {
                    print("Error: No data to decode")
                    return
                }
                guard let allLocations = try? JSONDecoder().decode([Buildings].self, from: data) else {
                    print("Error: Couldn't decode data into Blog")
                    return
                }
                self.locations = allLocations
                self.groupLocations(self.locations)
                self.refreshControl.endRefreshing()
                self.foldingTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedLocations.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as FoldingTableViewCell = cell else {return}
        cell.backgroundColor = .clear
        if groupedLocations != nil {
            
            let progressValue = self.groupedLocations[indexPath.row].ringValue!
            if values[indexPath.row] == 0{
                DispatchQueue.main.async {
                    cell.progressRing.startProgress(to: progressValue, duration: 1)
                }
                values[indexPath.row] = progressBarValues[indexPath.row]
            }else{
                cell.progressRing.startProgress(to: progressValue, duration: 0)
            }
            
            if  cell.progressRing.value != progressBarValues[indexPath.row] && indexPath.row > 2 {
                cell.progressRing.startProgress(to: progressValue , duration: 0)
            }
            cell.detailProgressRing.value = progressValue
            
            if !cellHeights.isEmpty{
                if cellHeights[indexPath.row] == Const.closeCellHeight {
                    cell.unfold(false, animated: false, completion: nil)
                } else {
                    cell.unfold(true, animated: false, completion: nil)
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingTableViewCell", for: indexPath) as! FoldingTableViewCell
        var currentLocation = groupedLocations[indexPath.row]
        
        displayCell(currentLocation: &currentLocation, cell: cell, indexPath: indexPath)
        
        let durations: [TimeInterval] = [0.1, 0.1, 0.1]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellHeights.isEmpty {
            return 0
        }else {
            return cellHeights[indexPath.row]
        }
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
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = headerMaxViewHeightConstraint.constant - y
        
        if newHeaderViewHeight > Const.headerViewMaxHeight {
            headerMaxViewHeightConstraint.constant = Const.headerViewMaxHeight
        } else if newHeaderViewHeight < Const.headerViewMinHeight {
            headerMaxViewHeightConstraint.constant = Const.headerViewMinHeight
            bestPlaceLabel.alpha = 0
            bestPlaceToStudyLabel.alpha = 0
            closestLocationLabel.alpha = 0
            BasedOnLocationLabel.alpha = 0
        } else {
            headerMaxViewHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
        
        
        if newHeaderViewHeight < 150 && newHeaderViewHeight >= 130 {
            bestPlaceLabel.alpha = 0
            BasedOnLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            bestPlaceToStudyLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            closestLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
        }else if newHeaderViewHeight < 130 && newHeaderViewHeight >= 89 {
            bestPlaceToStudyLabel.alpha = 0
            bestPlaceLabel.alpha = 0
            BasedOnLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            closestLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
        }else if newHeaderViewHeight < 89 && newHeaderViewHeight >= 54 {
            closestLocationLabel.alpha = 0
            BasedOnLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
        }else if newHeaderViewHeight < 54{
            BasedOnLocationLabel.alpha = 0
        }else {
            bestPlaceLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            bestPlaceToStudyLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            closestLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
            BasedOnLocationLabel.alpha = newHeaderViewHeight / Const.headerViewMaxHeight
        }
        
    }
    
}

extension HomeViewController {
    
    private func displayCell(currentLocation: inout Buildings, cell: FoldingTableViewCell, indexPath: IndexPath ){
        
        cell.updateCell(location: &currentLocation)
        groupedLocations[indexPath.row] = currentLocation
        if progressBarValues[indexPath.row] == 0 {
            progressBarValues[indexPath.row] = currentLocation.ringValue!
        }
        cell.detailsButton.tag = indexPath.row
        cell.detailsButton.addTarget(self, action: #selector(detailButtonPressed(sender: )), for: .touchUpInside)
    }
    
    private func groupLocations(_ locations: [Buildings]){
        
        libraryZeroAPs = []
        cumulativeLibraryZero = Buildings()
        libraryMinusAPs = []
        cumulativeLibraryMinus = Buildings()
        libraryTwentyfourAPs = []
        cumulativeLibraryTwentyFour = Buildings()
        librarySecondAPs = []
        cumulativeLibrarySecond = Buildings()
        libraryFirstAPs = []
        cumulativeLibraryFirst = Buildings()
        gymAPs = []
        cumulativeGym = Buildings()
        yemekhaneAPs = []
        cumulativeYemekhane = Buildings()
        iceAPs = []
        cumulativeIce = Buildings()
        neroSCAPs = []
        cumulativeNeroSC = Buildings()
        neroCASAPs = []
        cumulativeNeroCAS = Buildings()
        studentCenterAPs = []
        cumulativeStudentCenter = Buildings()
        
        locations.forEach { (building) in
            let stringParser = StringParser()
            let type = stringParser.parseLocationName(building.locationName!)
            let detailedType = stringParser.detailedParse(building.locationName!)
            var detailedBuilding = building
            groupedLocations.removeAll()
            switch type {
            case .libraryminus:
                libraryMinusAPs.append(building)
                cumulativeLibraryMinus.locationType = type
                cumulativeLibraryMinus.numberOfPeople! += building.numberOfPeople!
                cumulativeLibraryMinus.locationName = type.text
            case .libraryzero:
                libraryZeroAPs.append(building)
                cumulativeLibraryZero.locationType = type
                cumulativeLibraryZero.numberOfPeople! += building.numberOfPeople!
                cumulativeLibraryZero.locationName = type.text
            case .libraryfirst:
                libraryFirstAPs.append(building)
                cumulativeLibraryFirst.locationType = type
                cumulativeLibraryFirst.numberOfPeople! += building.numberOfPeople!
                cumulativeLibraryFirst.locationName = type.text
            case .librarysecond:
                detailedBuilding.detailedLocationType = detailedType
                librarySecondAPs.append(detailedBuilding)
                cumulativeLibrarySecond.locationType = type
                cumulativeLibrarySecond.numberOfPeople! += building.numberOfPeople!
                cumulativeLibrarySecond.locationName = type.text
                cumulativeLibrarySecond.detailedLocationType = detailedType
            case .librarytwentyfour:
                detailedBuilding.detailedLocationType = detailedType
                libraryTwentyfourAPs.append(detailedBuilding)
                cumulativeLibraryTwentyFour.locationType = type
                cumulativeLibraryTwentyFour.numberOfPeople! += building.numberOfPeople!
                cumulativeLibraryTwentyFour.locationName = type.text
            case .gym:
                gymAPs.append(building)
                cumulativeGym.locationType = type
                cumulativeGym.numberOfPeople! += building.numberOfPeople!
                cumulativeGym.locationName = type.text
            case .ice:
                iceAPs.append(building)
                cumulativeIce.locationType = type
                cumulativeIce.numberOfPeople! += building.numberOfPeople!
                cumulativeIce.locationName = type.text
            case .foodCourt:
                studentCenterAPs.append(building)
                cumulativeStudentCenter.locationType = type
                cumulativeStudentCenter.numberOfPeople! += building.numberOfPeople!
                cumulativeStudentCenter.locationName = type.text
            case .yemekhane:
                yemekhaneAPs.append(building)
                cumulativeYemekhane.locationType = type
                cumulativeYemekhane.numberOfPeople! += building.numberOfPeople!
                cumulativeYemekhane.locationName = type.text
            case .neroSC:
                neroSCAPs.append(building)
                cumulativeNeroSC.locationType = type
                cumulativeNeroSC.numberOfPeople! += building.numberOfPeople!
                cumulativeNeroSC.locationName = type.text
            case .neroCAS:
                neroCASAPs.append(building)
                cumulativeNeroCAS.locationType = type
                cumulativeNeroCAS.numberOfPeople! += building.numberOfPeople!
                cumulativeNeroCAS.locationName = type.text
            case .error: break
            }
        }
        groupedLocations = [cumulativeLibrarySecond, cumulativeLibraryFirst, cumulativeLibraryTwentyFour, cumulativeLibraryZero, cumulativeLibraryMinus, cumulativeNeroSC, cumulativeStudentCenter, cumulativeYemekhane, cumulativeGym, cumulativeNeroCAS, cumulativeIce]
        groupedAps = [librarySecondAPs, libraryTwentyfourAPs, gymAPs, iceAPs, yemekhaneAPs, libraryZeroAPs, libraryFirstAPs, libraryMinusAPs, studentCenterAPs, neroSCAPs, neroCASAPs]
        let libraryFloors = [cumulativeLibrarySecond, cumulativeLibraryFirst, cumulativeLibraryTwentyFour, cumulativeLibraryZero, cumulativeLibraryMinus]
        findBestPlaceToStudy(libraryFloors)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            var distance:CLLocationDistance = Double.infinity
            var closest:Buildings?
            if !groupedLocations.isEmpty {
                groupedLocations.forEach { (building) in
                    if building.locationType != .ice && building.locationType != .yemekhane &&  building.locationType != .foodCourt{
                        if building.locationType != nil {
                            let dist = location.distance(from: building.locationType!.coordinates)
                            if dist < distance {
                                distance = dist
                                closest = building
                            }
                        }
                    }
                }
                if Double(closest!.ringValue!) < 50.0 {
                    let type:LocationType = closest!.locationType!
                    
                    switch type {
                    case .gym: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available.  "
                    case .foodCourt: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Lunch Time!"
                    case .ice: closestLocationLabel.text = "\(closest!.locationType!.displayText)"
                    case .neroCAS: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to get some coffee."
                    case .neroSC: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Study & Coffee"
                    case .libraryminus: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to study!"
                    case .libraryzero: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to study!"
                    case .libraryfirst: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to study!"
                    case .librarysecond: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to study!"
                    case .librarytwentyfour: closestLocationLabel.text = "\(closest!.locationType!.displayText) seems available. Time to study!"
                    case .error: closestLocationLabel.text = "Error"
                    case .yemekhane: break
                    }
                    
                    locationManager.stopUpdatingLocation()
                }
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
}

extension HomeViewController {
    func findBestPlaceToStudy(_ buildings: [Buildings]){
        var best:Buildings = cumulativeLibrarySecond
        buildings.forEach { (building) in
            if building.ringValue! < best.ringValue! {
                best = building
            }
        }
        bestPlaceLabel.text = "Consider studying at \(String(describing: best.locationType!.displayText))."
    }
}
