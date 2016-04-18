//
//  ViewController.swift
//  weather-app
//
//  Created by liusy182 on 8/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView

extension Double {
    func roundToInt() -> Int{
        return Int(round(self))
    }
}

class PrettyWeatherViewController: UIViewController, UIScrollViewDelegate {
    static var INSET: CGFloat { get { return 20 } }
    
    private let backgroundView = UIImageView()
    private let overlayView = UIImageView()
    private let scrollView = UIScrollView()
    private let gradientView = UIView()
    private let currentWeatherView = CurrentWeatherView(frame: CGRectZero)
    private let hourlyForecastView = HourlyForecastView(frame: CGRectZero)
    private let daysForecastView = DailyForecastView(frame: CGRectZero)
    private var locationDatastore: LocationDatastore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationDatastore = LocationDatastore() {
            [weak self] location in
            FlickrDatastore().retrieveImageAtLat(
            location.lat,
            lon: location.lon){
                image in
                self?.render(image)
            }
            
            let weatherDatastore = WeatherDatastore()
            weatherDatastore.retrieveCurrentWeatherAtLat(location.lat, lon: location.lon) {
                currentWeatherCondition in
                self?.renderCurrent(currentWeatherCondition)
                return
            }
            weatherDatastore.retrieveHourlyForecastAtLat(location.lat, lon: location.lon) {
                hourlyWeatherConditions in
                self?.renderHourly(hourlyWeatherConditions)
                return
            }
            weatherDatastore.retrieveDailyForecastAtLat(location.lat, lon: location.lon, dayCnt: 7) {
                hourlyWeatherConditions in
                self?.renderDaily(hourlyWeatherConditions)
                return
            }
        }
        
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
        
        
        overlayView.contentMode = .ScaleAspectFill
        overlayView.clipsToBounds = true
        view.addSubview(overlayView)
        
        view.addSubview(gradientView)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        
    }
    
    // MARK: layout
    func layoutView() {
        constrain(backgroundView) {
            $0.edges ==  $0.superview!.edges
        }
        
        constrain(overlayView) {
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
        
        constrain(gradientView) {
            $0.edges ==  $0.superview!.edges
        }

    }
    
    // MARK: Render
    func render(image: UIImage?){
        
        guard let image = image else { return }
        backgroundView.image = image
        overlayView.image = image.blurredImageWithRadius(
            10, iterations: 20, tintColor: UIColor.clearColor())
        overlayView.alpha = 0
    }
    
    // MARK: style
    func style(){
        
        gradientView.backgroundColor = UIColor(white: 0, alpha: 1)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let blackColor = UIColor(white: 0, alpha: 0.0)
        let clearColor = UIColor(white: 0, alpha: 1.0)
        
        gradientLayer.colors = [blackColor.CGColor, clearColor.CGColor]
        
        gradientLayer.startPoint = CGPointMake(1.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 1.0)
        gradientView.layer.mask = gradientLayer
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let treshold: CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min (1.0, offset/treshold)
        
    }
    
    func renderCurrent(currentWeatherConditions: WeatherCondition){
        currentWeatherView.render(currentWeatherConditions)
    }
    
    func renderHourly(weatherConditions: Array<WeatherCondition>){
        hourlyForecastView.render(weatherConditions)
    }
    
    func renderDaily(weatherConditions: Array<WeatherCondition>){
        daysForecastView.render(weatherConditions)
    }

}

