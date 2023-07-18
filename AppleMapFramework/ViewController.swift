//
//  ViewController.swift
//  AppleMapFramework
//
//  Created by Mahmoud Abdulwahab on 22/06/2023.
//
import UIKit
import CoreLocation
import BMMapView

class ViewController: UIViewController {
    
    @IBOutlet weak var branchCardView: BranchCardView!
    @IBOutlet weak var mapView: BMMapView!
    
    
//    var _30Branche = [BranchCardCellViewModel]()
    
    var viewModel = AppleMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupMapView(with: mapView)
        viewModel.setupCardView(with: branchCardView)
    }
}
