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
    private let backgroundView = UIImageView()
    
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
    }
    
    // MARK: layout
    func layoutView() {
        constrain(backgroundView) { view in
            view.top == view.superview!.top
            view.bottom == view.superview!.bottom
            view.left == view.superview!.left
            view.right == view.superview!.right
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

