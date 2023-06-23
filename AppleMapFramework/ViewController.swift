//
//  ViewController.swift
//  AppleMapFramework
//
//  Created by Mahmoud Abdulwahab on 22/06/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: BMMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

//        Lat :   30.0352073
//        Lng : 31.563370237647135
        
        let annotation = BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0352073, longitude: 31.563370237647135), title: "Helmy Map! 😂")
        
         let annotations = [BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0352073, longitude: 31.563370237647135), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0473100180001, longitude: 31.254554576), title: "Mahmoud Map! 😎"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.0347433160001, longitude: 31.236700326000), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.048063332, longitude: 31.2441669310001), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 30.048063332, longitude: 31.2441669310001), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.240075228, longitude: 29.955911126), title: "Helmy Map! 😂"),BMAnnotation(coordinate: CLLocationCoordinate2D(latitude: 31.0334879, longitude: 30.4520954), title: "Helmy Map! 😂")]
        
        
        let location = CLLocation(latitude: annotation.coordinate.latitude + 0.002, longitude:  annotation.coordinate.longitude)
        
     //   mapView.addAnnotation(annotation)
        mapView.canShowCalloutView(true)
        mapView.setDefaultPinIcon(with: UIImage(named: "map-pin-icon")!)
        mapView.addAnnotations(annotations)
        mapView.centerToLocation(location,
                                 regionRadius: 50_000)
    }
}


extension ViewController:  BMMapDelegate{
    
    func didSelectAnnotation(_ annotation: BMAnnotation) {
        print("Movingggggg",annotation)
    }
    
    func didDrageOnMap() {
        print("Movingggggg")
    }
    
    func didTapOnCalloutView(_ annotation: BMAnnotation) {
        print(annotation)
    }
}
