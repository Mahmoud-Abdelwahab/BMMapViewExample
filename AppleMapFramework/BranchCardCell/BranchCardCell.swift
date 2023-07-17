//
//  BranchCardView.swift
//  MapDemo
//
//  Created by Mahmoud Abdulwahab on 24/06/2023.
//

import UIKit

class BranchCardCell: UICollectionViewCell {
    
    @IBOutlet weak var branchNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var branchAddressLabel: UILabel!
    @IBOutlet weak var supportOnlineBookingIcon: UIImageView!
    @IBOutlet weak var workingHoursIcon: UIImageView!
    @IBOutlet weak var workingHoursLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI() {
        self.layer.cornerRadius = 10
        branchNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        distanceLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        distanceLabel.textColor = .green
        branchAddressLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        branchAddressLabel.textColor = .green
        workingHoursLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.layer.masksToBounds = false
        //        self.layer.shadowColor = BMColors.black.withAlphaComponent(0.1).cgColor
        self.layer.shadowColor = .init(gray: 123, alpha: 0.1)
        
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 280, height: 150), cornerRadius: 10).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3
    }
    
    func configureUI(branch: BranchCardCellViewModel) {
        branchNameLabel.text = branch.branchName
        distanceLabel.text = String(describing: branch.distanceFromUserLocation) + " km"
        timeLabel.text = branch.timings
        workingHoursLabel.text =  branch.workingHoursText
        workingHoursIcon.image =  branch.workingHoursIcon
        branchAddressLabel.text = branch.address
        distanceLabel.isHidden = branch.shouldShowDistanceLabel
        supportOnlineBookingIcon.isHidden = branch.shouldShowSupportOnlineBookingIcon
        supportOnlineBookingIcon.image = branch.supportOnlineBookingIcon
    }
}


