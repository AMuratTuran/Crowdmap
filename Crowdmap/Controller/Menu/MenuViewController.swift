//
//  MenuViewController.swift
//  Crowdmap
//
//  Created by Murat Turan on 5.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

enum ModulesType: String {
    
    case settings = "Settings"
    case about = "About Us"
    case logout = "Log out"
    static func getTitleFor(title: ModulesType) -> String {
        return title.rawValue
    }
}

struct Module {
    var type: ModulesType!
    var icon: String!
}

class MenuViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    
    var modulesArray: [[Module]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        prepareModules()
        
    }
    
    func configureTableView(){
        topView.backgroundColor = UIColor(hexString: "#131d21")
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.tintColor = UIColor.black
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        
        
    }
    
    func prepareModules(){
        modulesArray.append([Module(type: .settings, icon: "settings"), Module(type: .about, icon: "about")])
        modulesArray.append([Module(type: .logout, icon: "exit")])
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func setupLogOutAlertController() {
        DispatchQueue.main.async {
            let logoutAlertVC = UIAlertController(title: nil, message: "Confirm Logout", preferredStyle: .alert)
            logoutAlertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            logoutAlertVC.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: {
                action in
                self.logOut()
            }))
            
            self.present(logoutAlertVC, animated: true, completion: nil)
        }
    }
    func logOut(){
        // firebase logout
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let startVC = storyBoard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
            self.present(startVC, animated: true, completion: nil)
            
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func pushNewVC(T:ModulesType){
        switch T {
        case .settings:
            // navigationController?.pushViewController(settingsVC, animated: true)
            break
        case .about:
            // navigationController?.pushViewController(aboutVC, animated: true)
            break
        case .logout:
            setupLogOutAlertController()
            break
        }
    }
}

extension MenuViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return modulesArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  modulesArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.update(T:modulesArray[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1.0
        }
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pushNewVC(T: modulesArray[indexPath.section][indexPath.row].type)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width , height: 20))
        
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
}
