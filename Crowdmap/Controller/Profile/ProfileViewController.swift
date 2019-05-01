//
//  ProfileViewController.swift
//  Crowdmap
//
//  Created by KS Murat Turan on 9.04.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfilePage()
    }
    
    private func configureProfilePage() {
        topView.backgroundColor = UIColor.navigationBarColor
        profilePictureView.layer.cornerRadius = profilePictureView.frame.size.width/2
        profilePictureView.clipsToBounds = true
        profilePictureView.layer.borderColor = UIColor.white.cgColor
        profilePictureView.layer.borderWidth = 5.0
        profilePictureView.image = UIImage(named: "pp")
    }

}
