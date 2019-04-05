//
//  PopularLocationCollectionViewCell.swift
//  Crowdmap
//
//  Created by Murat Turan on 13.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit
import UICircularProgressRing

class PopularLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationIV: UIImageView!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    private func setupCell(){
        self.layer.backgroundColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}
