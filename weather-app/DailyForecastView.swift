//
//  DailyForecastView.swift
//  weather-app
//
//  Created by liusy182 on 8/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import UIKit
import Cartography

class DailyForecastView: UIView {
    static var HEIGHT: CGFloat { get { return 300 } }
    
    private var forecastCells = Array<DayForecastView>()
    
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
    
    // MARK: Setup
    func setup(){
        (0..<7).forEach { _ in
            let cell = DayForecastView(frame: CGRectZero)
            forecastCells.append(cell)
            addSubview(cell)
        }
    }

    func layoutView(){
//        constrain(self) { view in
//            view.height == DailyForecastView.HEIGHT
//            return
//        }
        
        constrain(forecastCells.first!) {
            $0.top == $0.superview!.top
        }
        
        for idx in 0..<(forecastCells.count - 1) {
            let cell = forecastCells[idx]
            let nextCell = forecastCells[idx+1]
            constrain(cell, nextCell) {
                $0.bottom == $1.top
            }
        }
        
        forecastCells.forEach { cell in
            constrain(cell) {
                $0.left == $0.superview!.left
                $0.right == $0.superview!.right
            }
        }
        
        constrain(forecastCells.last!) {
            $0.bottom == $0.superview!.bottom
        }
    }
    func style(){
        //backgroundColor = UIColor.blueColor()
    }
    
    func render(){
        forecastCells.forEach {
            $0.render()
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
