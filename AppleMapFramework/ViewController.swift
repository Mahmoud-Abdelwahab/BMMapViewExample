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
    
    @IBOutlet weak var appleMapView: BMAppleMapView!
    var viewModel = AppleMapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupMapView(with: appleMapView)
        viewModel.setupCardView(with: branchCardView)
    }
}
