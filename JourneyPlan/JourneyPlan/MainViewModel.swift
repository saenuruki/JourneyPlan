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
    let historyTexts$: Observable<String>
    
    let locations = BehaviorRelay<[Location]>(value: [])
    let inputTexts = BehaviorRelay<String>(value: "")
    let historyTexts = BehaviorRelay<String>(value: "")

    let locationTrigger = PublishSubject<[Location]>()
    let inputTextsTrigger = PublishSubject<String>()
    let historyTextsTrigger = PublishSubject<String>()

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
        
        historyTexts$ = Observable
            .of(
                Observable.just(""),
                historyTextsTrigger.asObservable()
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
        
        historyTexts$
            .subscribe(onNext: { [weak self] texts in
                guard let wself = self else { return }
                wself.historyTexts.accept(texts)
            })
            .disposed(by: bag)
    }
}

extension MainViewModel {
    
    func requestLocations() {
        let newLocations = getLocations()
        locationTrigger.onNext(newLocations)
    }
    
    func getLocations() -> [Location] {
        let list = """
        [{
            "name": "船の科学館",
            "location": "東京都品川区東八潮３丁目１",
            "rate": 3.5,
            "imageURL": "https://media-cdn.tripadvisor.com/media/photo-m/1280/1b/26/26/69/a-closed-museum.jpg",
            "tags": ["子供","歴史","工事","トイレ","小学校","係留施設","9月30日","散策","日本化学未来館","オリンピック"]
        },
        {
            "name": "潮風公園",
            "location": "東京都品川区東八潮１",
            "rate": 3.8,
            "imageURL": "https://www.tokyo-odaiba.net/wp-content/uploads/2018/11/8190abb3413330b64c794f7f00220513-1.jpg",
            "tags": ["バーベキュー","ポケモン","オリンピック","夜景","ビーチバレー","夕日","船","景観"]
        },
        {
            "name": "自由の女神像",
            "location": "東京都港区台場１丁目４ 台場海浜公園内",
            "rate": 4.3,
            "imageURL": "https://blog-imgs-42.fc2.com/k/a/z/kazu281/20101221210354691.jpg",
            "tags": ["ショッピングモール","日没","写真","湾","デートスポット","虹","ライトアップ","観覧車"]
        }]
        """.data(using: .utf8)!
        let locations: [Location] = try! JSONDecoder().decode([Location].self, from: list)
        return locations
    }
}
