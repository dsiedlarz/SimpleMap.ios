//
//  ViewController.swift
//  SimpleMap
//
//  Created by Dawid Siedlarz private on 29.10.2017.
//  Copyright © 2017 Dawid Siedlarz private. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    @IBOutlet weak var LocationName: UILabel!
    
    var myLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        if (CLLocationManager.locationServicesEnabled())
        {
            myLocationManager = CLLocationManager()
            myLocationManager.delegate = self
            myLocationManager.requestWhenInUseAuthorization()
            myLocationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
            print(locations)
            guard let lastLocation = locations.last else {
                return
            }
            print(lastLocation.coordinate)
            print(lastLocation.speed)
            MapView.setCenter(lastLocation.coordinate, animated: true)
        }
        
        let myGeocoder = CLGeocoder()
        myGeocoder.geocodeAddressString("Mickiewicza 30, Kraków")
        { (placemarks, error) in
            let firstPlacemark = placemarks?.first
            print(firstPlacemark?.location?.coordinate)
        }
        
        
        let aghCoord = CLLocationCoordinate2D(latitude:
            50.064528, longitude: 19.923556)
        MapView.setCenter(aghCoord, animated: true)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01,
                                    longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: aghCoord,
                                        span: span)
        MapView.setRegion(region, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

