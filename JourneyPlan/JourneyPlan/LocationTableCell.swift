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

    static let cellHeight: CGFloat = 72

    fileprivate var bag = DisposeBag()

    @IBOutlet weak var cellView: UIView!
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

//        contentView.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        contentView.layer.shadowOpacity = 0.2
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowRadius = 2.0
        cellView.layer.cornerRadius = 8
        cellView.layer.masksToBounds = true
        
        thumbnailImageView.kf.setImage(with: URL(string: location.imageURL))
        nameLabel.text = location.name
        addressLabel.text = location.location
    }
}
