//
//  ViewController.swift
//  Find the users location
//
//  Created by admin on 05/02/2020.
//  Copyright © 2020 AM Kirsch. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var latitude: CLLocationDegrees?
    var longitude:CLLocationDegrees?
    var latDelta: CLLocationDegrees?
    var longDelta: CLLocationDegrees?
    var span: MKCoordinateSpan?
    var coordinates: CLLocationCoordinate2D?
    var region:MKCoordinateRegion?
    var annotation = MKPointAnnotation()
    var locationManager = CLLocationManager()
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        latitude = 31.77660
          
        longitude = 35.23382

        latDelta = 0.05
          
        longDelta = 0.05
          
          
        span = MKCoordinateSpan(latitudeDelta: latDelta!, longitudeDelta: longDelta!)
      
        coordinates = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
          
        region = MKCoordinateRegion(center: coordinates!, span: span!)
          
        map.setRegion(region!, animated: true)
          
      
          
        annotation.title = "The Western Wall"
         
        annotation.subtitle = "Makom Kadosh"
          
        annotation.coordinate = coordinates!
          
        map.addAnnotation(annotation)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
        
        span = MKCoordinateSpan(latitudeDelta: latDelta!, longitudeDelta: longDelta!)
        
        coordinates = locations[0].coordinate
        
        region = MKCoordinateRegion(center: coordinates!, span: span!)
        
        map.setRegion(region!, animated: true)
        
    //flag current location
                
        annotation.title = "You Are Here"
        
        annotation.subtitle = "i see you"
        
        annotation.coordinate = coordinates!
        
        map.addAnnotation(annotation)
        
    }
    
    @objc  func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint =  gestureRecognizer.location(in: self.map)
        
        coordinates = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        annotation.title = "New Place"
        
        annotation.subtitle = "you long-pressed here"
        
        annotation.coordinate = coordinates!
        
        map.addAnnotation(annotation)
    }
}

