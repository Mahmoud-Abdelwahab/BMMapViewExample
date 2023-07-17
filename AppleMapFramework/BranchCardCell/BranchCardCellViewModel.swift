//
//  BranchCardCellViewModel.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 09/07/2023.
//

import UIKit
import CoreLocation

struct BranchCardCellViewModel {
    let timings: String
    let distanceFromUserLocation: Double
    let branchName: String
    let address: String
    let workingHoursText: String
    let workingHoursIcon: UIImage
    let supportOnlineBookingIcon : UIImage
    let shouldShowDistanceLabel: Bool
    let shouldShowSupportOnlineBookingIcon: Bool
    let coordinates: CLLocationCoordinate2D
}
