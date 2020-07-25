//
//  LocationTableCell.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/25.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import EMTNeumorphicView
import Kingfisher

class LocationTableCell: UITableViewCell {

    static let cellHeight: CGFloat = 60

    fileprivate var bag = DisposeBag()

    @IBOutlet weak var cellView: EMTNeumorphicView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        bag = DisposeBag()
    }

    func configure(by location: Location) {
        configureUI(by: location)
    }
}

extension LocationTableCell {

    fileprivate func configureUI(by location: Location) {
        
        cellView.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        cellView.neumorphicLayer?.cornerRadius = 8
        cellView.neumorphicLayer?.depthType = .concave
        cellView.neumorphicLayer?.elementDepth = 4
        cellView.neumorphicLayer?.edged = true
        
        thumbnailImageView.kf.setImage(with: URL(string: location.imageURL))
        nameLabel.text = location.name
        addressLabel.text = location.location
    }
}
