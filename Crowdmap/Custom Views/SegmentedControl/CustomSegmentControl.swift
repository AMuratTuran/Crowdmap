//
//  CustomSegmentControl.swift
//  Crowdmap
//
//  Created by Murat Turan on 25.03.2019.
//  Copyright © 2019 Murat Turan. All rights reserved.
//

import Foundation
import UIKit

final class CustomSegmentControl: UISegmentedControl {
    let indicatorHeight: CGFloat = 3
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.flatMint
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override var selectedSegmentIndex: Int {
        didSet {
            changeSelectedIndex()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        indicatorView.frame = setupIndicatorFrame(index: selectedSegmentIndex)
    }
    
    private func setupView() {
        addSubview(indicatorView)
        backgroundColor = UIColor.navigationBarColor
        tintColor = UIColor.clear
        let selectedTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "OpenSans-Bold", size: 17.0),
                                       NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "OpenSans-Regular", size: 17.0),
        NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        setTitleTextAttributes(selectedTextAttributes, for: .selected)
        setTitleTextAttributes(normalTextAttributes, for: .normal)
        addTarget(self, action: #selector(changeSelectedIndex), for: .valueChanged)
    }
    
    private func setupIndicatorFrame(index: Int = 0) -> CGRect {
        let indicatorWidth = frame.width / CGFloat(numberOfSegments * 3 )
        let x = CGFloat(index) * (frame.width / CGFloat(numberOfSegments)) + indicatorWidth
        let y = frame.height - 3
        return CGRect(x: x, y: y, width: indicatorWidth, height: indicatorHeight)
    }
    
    @objc func changeSelectedIndex() {
        indicatorView.frame = setupIndicatorFrame(index: selectedSegmentIndex)
    }
}


