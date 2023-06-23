//
//  BMMapView.swift
//  AppleMapFramework
//
//  Created by Mahmoud Abdulwahab on 22/06/2023.
//

import UIKit
import MapKit

class BMMapView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak private var mapView: MKMapView!
    
    // MARK: - Properties
    weak var delegate: BMMapDelegate?
    private var defaultPinIcon: UIImage?
    private var canShowCallout: Bool?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNibFromFile()
        setupUI()
    }
}



// MARK: - Configurations
extension BMMapView {
    
    func setupUI() {
        loadNibFromFile()
        mapView.delegate = self
    }
}


extension BMMapView: MKMapViewDelegate {
   
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let bmAnnotation = BMAnnotation(
            coordinate: annotation.coordinate,
            title: annotation.title ?? nil,
            subtitle: annotation.subtitle ?? nil)
    
        delegate?.didSelectAnnotation(bmAnnotation)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        delegate?.didDrageOnMap()
    }
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if  let annotation = mapView.annotations.first(where: { !($0 is MKUserLocation) }) {
            mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")

        if let canShowCallout = canShowCallout {
            annotationView.canShowCallout = canShowCallout
        }
        if let defaultPinIcon = defaultPinIcon {
            annotationView.image = defaultPinIcon
        }
        
        let button = AnnotationButton(type: .detailDisclosure)
        button.addTarget(self, action: #selector(pinAction(_:)), for: .touchUpInside)
        annotationView.rightCalloutAccessoryView = button
        if let pointAnnotation = annotation as? MKPointAnnotation {
            button.annotation = pointAnnotation
        }
        return annotationView
    }
    
    @objc private func pinAction(_ pinButton: AnnotationButton) {
        guard let annotationPointModel = pinButton.annotation else { return }
        let annotation = BMAnnotation(coordinate: annotationPointModel.coordinate, title: annotationPointModel.title, subtitle: annotationPointModel.subtitle)
        delegate?.didTapOnCalloutView(annotation)
    }
}


extension BMMapView: BMMapInputType {
    
    func addAnnotations(_ annotatios: [BMAnnotation]) {
        annotatios.forEach(addAnnotation)
    }
    
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        print("💥", location, regionRadius)
    }
    
    func addAnnotation(_ annotation: BMAnnotation) {
        let annotations = MKPointAnnotation()
        annotations.title = annotation.title
        annotations.coordinate = annotation.coordinate
        mapView.addAnnotation(annotations)

        print("💥", annotation)
    }
    
    func removeAnnotation(_ annotation: MKAnnotation) {
        print("💥", annotation)
    }
    
    func removeAnnotations(_ annotatios: [MKAnnotation]) {
        mapView.removeAnnotations(annotatios)
        print("💥", annotatios)
    }
    
    func selectMarker(_ marker: BMAnnotation) {
        print("💥", marker)
    }
    
    func animateToCoordinate(_ coordinate: CLLocationCoordinate2D, withZoomLevel zoomLevel: Double) {
        print("💥", coordinate, zoomLevel)
    }
    
    func drawAnnotations(_ annotations: [MKAnnotation]) {
        print("💥",annotations)
    }
    
    func fitAnnotationsOnScreen() {
        print("💥")
    }
    
    func setDefaultPinIcon(with icon: UIImage) {
        defaultPinIcon = icon
    }
    
    func canShowCalloutView(_ isShown: Bool) {
        canShowCallout = isShown
    }
}


final class AnnotationButton: UIButton {
    var annotation: MKPointAnnotation?
}
