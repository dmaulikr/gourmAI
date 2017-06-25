//
//  ViewController.swift
//  Gourmai
//
//  Created by Zack Esm on 6/24/17.
//  Copyright © 2017 Zack Esm. All rights reserved.
//

import UIKit
import CoreLocation

class HomeVC: UIViewController {
    
    var takePicButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.brown
        title = "Home"
        setupViews()
        takePicButton.addTarget(self, action: #selector(takePic), for: .touchUpInside)
        
//        let locationManager = CLLocationManager()
//        locationManager.delegate = self
    }
    
    func takePic() {
        let takePicVC = TakePicVC()
        self.navigationController?.pushViewController(takePicVC, animated: true)
    }
    
    private func setupViews() {
        let margins = view.layoutMarginsGuide
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let topMargin = navBarHeight! + 8
        
        takePicButton = UIButton()
        takePicButton.translatesAutoresizingMaskIntoConstraints = false
        takePicButton.setTitle("Take Picture", for: .normal)
        takePicButton.backgroundColor = UIColor.blue
        takePicButton.layer.cornerRadius = 15
        view.addSubview(takePicButton)
        
        takePicButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: -8).isActive = true
        takePicButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 8).isActive = true
        takePicButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: topMargin + 20).isActive = true
        takePicButton.bottomAnchor.constraint(equalTo: margins.centerYAnchor, constant: 8).isActive = true
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}

//extension HomeVC: CLLocationManagerDelegate {
//    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            // authorized location status when app is in use; update current location
//            manager.startUpdatingLocation()
//            // implement additional logic if needed...
//        } else {
//            print("NOT USING LOCATION")
//        }
//        // implement logic for other status values if needed...
//    }
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        if let location = locations.first as? CLLocation {
//            // implement logic upon location change and stop updating location until it is subsequently updated
//            manager.stopUpdatingLocation()
//        }
//    }
//}

