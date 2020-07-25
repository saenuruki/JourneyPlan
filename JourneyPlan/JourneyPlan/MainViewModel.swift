//
//  MainViewModel.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/25.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {

    let bag = DisposeBag()

    let locations$: Observable<[Location]>
    let inputTexts$: Observable<String>
    
    let locations = BehaviorRelay<[Location]>(value: [])
    let inputTexts = BehaviorRelay<String>(value: "")

    let locationTrigger = PublishSubject<[Location]>()
    let inputTextsTrigger = PublishSubject<String>()

    init() {

        locations$ = Observable
            .of(
                Observable.just([]),
                locationTrigger.asObservable()
            )
            .concat()
            .share(replay: 1)

        inputTexts$ = Observable
            .of(
                Observable.just(""),
                inputTextsTrigger.asObservable()
            )
            .concat()
            .share(replay: 1)

        locations$
            .subscribe(onNext: { [weak self] locations in
                guard let wself = self else { return }
                wself.locations.accept(locations)
            })
            .disposed(by: bag)

        inputTexts$
            .subscribe(onNext: { [weak self] texts in
                guard let wself = self else { return }
                wself.inputTexts.accept(texts)
            })
            .disposed(by: bag)
    }
}

extension MainViewModel {
    
    func getHomeData() {
//        firestoreManager.getShops(from: lastNewSnapShot, isRefresh: isRefresh, success: { [weak self] (shops, lastSnapShot)  in
//            guard let wself = self else { return }
//            if isRefresh {
//                wself.newShopsTrigger.onNext(shops)
//            }
//            else {
//                wself.newShopsTrigger.onNext(wself.newShops.value + shops)
//            }
//            wself.lastNewSnapShot = lastSnapShot
//            result()
//        })
    }
    
    func getBestShop() {
//        firestoreManager.getShopsByViewCount(from: lastBestSnapShot, isRefresh: isRefresh, success: { [weak self] (shops, lastSnapShot) in
//            guard let wself = self else { return }
//            if isRefresh {
//                wself.bestShopsTrigger.onNext(shops)
//            }
//            else {
//                wself.bestShopsTrigger.onNext(wself.bestShops.value + shops)
//            }
//            wself.lastBestSnapShot = lastSnapShot
//            result()
//        })
    }
}
