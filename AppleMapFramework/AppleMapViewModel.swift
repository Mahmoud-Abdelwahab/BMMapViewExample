//
//  AppleMapViewModel.swift
//  AppleMapFramework
//
//  Created by Mahmoud Abdulwahab on 17/07/2023.
//

import Foundation
import BMMapView
import CoreLocation
import UIKit

final class AppleMapViewModel {
    
    weak var branchCardView: ReusableCardViewType?
    weak var mapView: BMMapInputType?
    var _30Branche = [BranchCardCellViewModel]()

    init() {
        mapAnnotationToBranchCellModel()
    }
}

extension AppleMapViewModel {
    
    func setupMapView(with mapView: BMMapInputType) {
        self.mapView = mapView
        
        configureMap()
    }
    
    func setupCardView(with cardView: ReusableCardViewType) {
        branchCardView = cardView
        branchCardView?.didTapOnCard = { [weak self] annotation in
            let branchAnnotation =  BMAnnotation(coordinate: annotation.coordinates, title: annotation.branchName)
            print("Tap on card : 🎉")
        }
        
        branchCardView?.animateCamera = { [weak self] annotation in
            let branchAnnotation =  BMAnnotation(coordinate: annotation.coordinates, title: annotation.branchName)
            self?.mapView?.animateToAnnotation(branchAnnotation)
            self?.mapView?.scaleAnnotation(branchAnnotation)
        }
        
        branchCardView?.configureCell(viewModel: _30Branche)
    }
    
    private func configureMap() {
        mapView?.delegate = self
        let annotation = bmAnnotations[5]
        
        mapView?.setDefaultPinIcon(with: UIImage(named: "map-pin-icon")!)
        mapView?.centerToAnnotation(annotation,
                                    regionRadius: 50_000)
        ///
        //MARK: - Basic businsess
//                mapView?.shouldShowCalloutView(true)
//                mapView?.addAnnotations(bmAnnotations)
//                branchCardView?.didTapOnCard = { [weak self] annotation in
//                    let branchAnnotation =  BMAnnotation(coordinate: annotation.coordinates, title: annotation.branchName)
//                    self?.mapView?.selectAnnotation(branchAnnotation, regionRadius: 50_000)
//                }
        ///
        
        //MARK: - BookVisit businsess
        mapView?.fitAnnotationsInTheScreen(bmAnnotations)
        mapView?.scaleAnnotation(bmAnnotations[0], selectedScale: 1.7)
    }
    
    func mapAnnotationToBranchCellModel() {
        for (index, element) in bankBranches.enumerated() {
            let model = BranchCardCellViewModel(timings: "10:10", distanceFromUserLocation: 6000,
                                                branchName: "✅ Branch: ----> \(index)",
                                                address: "mohamed mahmoud street",
                                                workingHoursText: "10:00 t0 16:00",
                                                workingHoursIcon: UIImage(systemName: "mappin.circle.fill")!,
                                                supportOnlineBookingIcon: UIImage(systemName: "mappin.circle.fill")!,
                                                shouldShowDistanceLabel: true, shouldShowSupportOnlineBookingIcon: true,
                                                coordinates: element)
            _30Branche.append(model)
        }
    }
}

extension AppleMapViewModel: BMMapDelegate {
    
    func didSelectAnnotation(_ annotation: BMAnnotation) {
        mapView?.animateToAnnotation(annotation, zoomLevel: nil, animated: true)
        mapView?.scaleAnnotation(annotation, selectedScale: 1.5)
        let index = _30Branche.firstIndex(where: {$0.coordinates == annotation.coordinate})!
        branchCardView?.scrollTo(desiredIndex: index)
    }
    
    func didDrageOnMap() {
        print("Draging....")
    }
    
    func didTapOnCalloutView(_ annotation: BMAnnotation) {
        
        print("Callout Tapped", annotation)
    }
}


let bankBranches: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 30.0626, longitude: 31.2497),
    CLLocationCoordinate2D(latitude: 30.0762, longitude: 31.3359),
    CLLocationCoordinate2D(latitude: 30.0595, longitude: 31.2345),
    CLLocationCoordinate2D(latitude: 30.0613, longitude: 31.2283),
    CLLocationCoordinate2D(latitude: 30.0573, longitude: 31.2449),
    CLLocationCoordinate2D(latitude: 30.0517, longitude: 31.2351),
    CLLocationCoordinate2D(latitude: 30.0451, longitude: 31.2312),
    CLLocationCoordinate2D(latitude: 30.0489, longitude: 31.2603),
    CLLocationCoordinate2D(latitude: 30.0456, longitude: 31.2427),
    CLLocationCoordinate2D(latitude: 30.0408, longitude: 31.2331),
    CLLocationCoordinate2D(latitude: 30.0435, longitude: 31.2303),
    CLLocationCoordinate2D(latitude: 30.0546, longitude: 31.2289),
    CLLocationCoordinate2D(latitude: 30.0364, longitude: 31.2097),
    CLLocationCoordinate2D(latitude: 30.0442, longitude: 31.2364),
    CLLocationCoordinate2D(latitude: 30.0437, longitude: 31.2141),
    CLLocationCoordinate2D(latitude: 30.0345, longitude: 31.2339),
    CLLocationCoordinate2D(latitude: 30.0301, longitude: 31.2357),
    CLLocationCoordinate2D(latitude: 30.0319, longitude: 31.2237),
    CLLocationCoordinate2D(latitude: 30.0403, longitude: 31.2113),
    CLLocationCoordinate2D(latitude: 30.0369, longitude: 31.2438),
    CLLocationCoordinate2D(latitude: 30.0577, longitude: 31.2485),
    CLLocationCoordinate2D(latitude: 30.0529, longitude: 31.2382),
    CLLocationCoordinate2D(latitude: 30.0400, longitude: 31.2246),
    CLLocationCoordinate2D(latitude: 30.0581, longitude: 31.2440),
    CLLocationCoordinate2D(latitude: 30.0512, longitude: 31.2575),
    CLLocationCoordinate2D(latitude: 30.0621, longitude: 31.1976),
    CLLocationCoordinate2D(latitude: 30.0617, longitude: 31.1962),
    CLLocationCoordinate2D(latitude: 30.0637, longitude: 31.2014),
    CLLocationCoordinate2D(latitude: 30.0583, longitude: 31.2239),
    CLLocationCoordinate2D(latitude: 30.0638, longitude: 31.2022)
]

var bmAnnotations = bankBranches.map( { BMAnnotation(coordinate: $0 , title: "Branch 1") } )

