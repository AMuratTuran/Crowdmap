//
//  buttonWithImage.swift
//  Crowdmap
//
//  Created by Murat Turan on 23.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 14), bottom: 3, right: 2)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)! + 2 )
        }
    }
}

