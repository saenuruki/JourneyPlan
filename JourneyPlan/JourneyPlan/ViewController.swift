//
//  ViewController.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/25.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import EMTNeumorphicView

class ViewController: UIViewController {
    
    @IBOutlet weak var nlpTextView: UITextView!
    @IBOutlet weak var textFieldView: EMTNeumorphicView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButton: EMTNeumorphicButton!
    @IBOutlet weak var searchButton: EMTNeumorphicButton!
    @IBOutlet weak var placeholderImageView: UIImageView!
    
    fileprivate let bag = DisposeBag()
    fileprivate(set) var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureVM()
        configureTableView()
        configureTextView()
        configureTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.requestLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configureUI() {
        
        textFieldView.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        textFieldView.neumorphicLayer?.cornerRadius = 24
        textFieldView.neumorphicLayer?.depthType = .concave
        textFieldView.neumorphicLayer?.elementDepth = 4
        textFieldView.neumorphicLayer?.edged = true
        
        resetButton.contentVerticalAlignment = .fill
        resetButton.contentHorizontalAlignment = .fill
        resetButton.imageEdgeInsets = UIEdgeInsets(top: 26, left: 24, bottom: 22, right: 24)
        resetButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        resetButton.neumorphicLayer?.cornerRadius = 30
        resetButton.neumorphicLayer?.edged = true
        
        searchButton.contentVerticalAlignment = .fill
        searchButton.contentHorizontalAlignment = .fill
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 26, left: 24, bottom: 22, right: 24)
        searchButton.neumorphicLayer?.elementBackgroundColor = UIColor.white.cgColor
        searchButton.neumorphicLayer?.cornerRadius = 30
        searchButton.neumorphicLayer?.edged = true
    }
    
    private func configureVM() {
        
        resetButton
            .rx.tap
            .throttle(.milliseconds(700), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let wself = self else { return }
                wself.viewModel.inputTextsTrigger.onNext("")
            })
            .disposed(by: bag)
        
        searchButton
            .rx.tap
            .throttle(.milliseconds(700), latest: false, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let wself = self else { return }
                wself.viewModel.searchLocation()
            })
            .disposed(by: bag)
        
        nlpTextView
            .rx.text
            .orEmpty
            .bind(to: viewModel.inputTextsTrigger)
            .disposed(by: bag)
        
        viewModel
            .locations$
            .subscribe(onNext: { [weak self] locations in
                guard let wself = self else { return }
                wself.placeholderImageView.isHidden = locations.count != 0
                wself.tableView.reloadData()
            })
            .disposed(by: bag)
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: "LocationTableCell", bundle: nil),forCellReuseIdentifier:"LocationTableCell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 72
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.reloadData()
    }
    
    private func configureTextView() {
        nlpTextView.delegate = self
        nlpTextView.backgroundColor = .white
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                guard let wself = self else { return }
                wself.nlpTextView.resignFirstResponder()

            })
            .disposed(by: bag)
        view.addGestureRecognizer(tapGesture)
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableCell", for: indexPath) as! LocationTableCell
        cell.configure(by: viewModel.locations.value[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapしたよ")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LocationTableCell.cellHeight
    }
}

extension ViewController: UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        // ここでカーソル開始位置を判断して、キーボードの高さを取得して、キーボードに隠れそうだったらScrollする
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
    }
}
