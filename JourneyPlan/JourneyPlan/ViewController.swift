//
//  ViewController.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/25.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import UIKit
import SnapKit
import EMTNeumorphicView

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldView: EMTNeumorphicView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButton: EMTNeumorphicButton!
    @IBOutlet weak var searchButton: EMTNeumorphicButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func configureUI() {
        
        textFieldView.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        textFieldView.neumorphicLayer?.cornerRadius = 24
        textFieldView.neumorphicLayer?.depthType = .concave
        textFieldView.neumorphicLayer?.elementDepth = 4
        
        resetButton.contentVerticalAlignment = .fill
        resetButton.contentHorizontalAlignment = .fill
        resetButton.imageEdgeInsets = UIEdgeInsets(top: 26, left: 24, bottom: 22, right: 24)
        resetButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        resetButton.neumorphicLayer?.cornerRadius = 30
        
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 26, left: 24, bottom: 22, right: 24)
        searchButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        searchButton.neumorphicLayer?.cornerRadius = 30
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
}


extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return UITableViewCell()
//
//        switch indexPath.section {
//        case 0:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.shopDetailHeaderCarouselTableCell, for: indexPath) else { return UITableViewCell() }
//            cell.configure(viewModel: viewModel)
//            cell.selectionStyle = .none
//            return cell
//        case 1:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.shopDetailInfoTableCell, for: indexPath) else { return UITableViewCell() }
//            cell.configure(shop: viewModel.shop.value)
//            cell.selectionStyle = .none
//            return cell
//        case 2:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.shopDetailMapTableCell, for: indexPath) else { return UITableViewCell() }
//            cell.configure(latitude: viewModel.shop.value.latitude, longitude: viewModel.shop.value.longitude)
//            cell.selectionStyle = .none
//            return cell
//        case 3:
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.shopDetailFooterTableCell, for: indexPath) else { return UITableViewCell() }
//            cell.configure()
//            cell.selectionStyle = .none
//            cell.footerButtonHandler = { [weak self] in
//                guard let wself = self else { return }
//                let shop = wself.viewModel.shop.value
//                wself.navigationController?.pushViewController(WebViewController(url: URL(string: shop.webURLString), title: shop.name), animated: true)
//
//            }
//            return cell
//        default:
//            return UITableViewCell()
//        }
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapしたよ")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
//        switch indexPath.section {
//        case 0:
//            return ShopDetailHeaderCarouselTableCell.cellHeight
//        case 1:
//            return ShopDetailInfoTableCell.calcCellHeight(from: viewModel.shop.value)
//        case 2:
//            return ShopDetailMapTableCell.cellHeight
//        case 3:
//            return ShopDetailFooterTableCell.cellHeight
//        default:
//            return 0
//        }
    }
}
