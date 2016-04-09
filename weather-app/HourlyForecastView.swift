//
//  HourlyForecastView.swift
//  weather-app
//
//  Created by liusy182 on 8/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import UIKit
import Cartography

class HourlyForecastView: UIView {
    static var HEIGHT: CGFloat { get { return 60 } }
    
    private var didSetupConstraints = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        if didSetupConstraints {
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
    
    func setup(){
    }
    
    func layoutView(){
        constrain(self) { view in
            view.height == HourlyForecastView.HEIGHT
            return
        }
    }
    
    func style(){
        backgroundColor = UIColor.greenColor()
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
