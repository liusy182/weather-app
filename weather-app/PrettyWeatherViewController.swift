//
//  ViewController.swift
//  weather-app
//
//  Created by liusy182 on 8/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import UIKit
import Cartography

class PrettyWeatherViewController: UIViewController {
    static var INSET: CGFloat { get { return 20 } }
    
    private let backgroundView = UIImageView()
    private let scrollView = UIScrollView()
    private let currentWeatherView = CurrentWeatherView(frame: CGRectZero)
    private let hourlyForecastView = HourlyForecastView(frame: CGRectZero)
    private let daysForecastView = DailyForecastView(frame: CGRectZero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: setup
    func setup(){
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        
        view.addSubview(scrollView)
    }
    
    // MARK: layout
    func layoutView() {
        constrain(backgroundView) {
            $0.edges ==  $0.superview!.edges
        }
        
        constrain(scrollView) {
            $0.edges ==  $0.superview!.edges
        }
        
        constrain(currentWeatherView) {
            $0.width == $0.superview!.width
            $0.centerX == $0.superview!.centerX
        }
        
        let currentWeatherInsect: CGFloat =
            view.frame.height - CurrentWeatherView.HEIGHT - PrettyWeatherViewController.INSET
        
        constrain(currentWeatherView) {
            $0.top == $0.superview!.top + currentWeatherInsect
        }
        
        constrain(hourlyForecastView, currentWeatherView) {
            $0.top == $1.bottom + PrettyWeatherViewController.INSET
            $0.width == $0.superview!.width
            $0.centerX == $0.superview!.centerX
        }
        
        constrain(daysForecastView, hourlyForecastView) {
            $0.top == $1.bottom + PrettyWeatherViewController.INSET
            $0.width == $1.width
            $0.bottom == $0.superview!.bottom - PrettyWeatherViewController.INSET
            $0.centerX == $0.superview!.centerX
        }
    }
    
    // MARK: Render
    func render(image: UIImage?){
        if let image = image {
            backgroundView.image = image
        }
    }
    
    // MARK: style
    func style(){
    }


}

