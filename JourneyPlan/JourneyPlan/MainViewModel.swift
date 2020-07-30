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
    
    var locationList: [Location] = []

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
        locationList = getLocations()
    }
    
    func searchLocation(with content: String) {
        
        GoogleNLPRequest.getEntities(with: content, complation: { [weak self] entities in
        guard let wself = self else { return }
            print(entities)
            
            if entities.isEmpty { return }
            
        })
    }
    
    func getLocations() -> [Location] {
        let list = """
        [
        {
            "name": "浅草寺",
            "location": "東京都台東区浅草２丁目３−１",
            "rate": 4.5,
            "imageURL": "https://static.retrip.jp/spot/cadf7023-7de8-405a-b8cf-d385e0b670b1/images/377f0f8e-e1e1-4c38-85e7-b1b3f54e5cd9_m.jpg",
            "tags": ["観光客","仲見世","スカイツリー","おみくじ","ライトアップ","提灯","人力車","屋台","文化"]
        }
        ]
        """.data(using: .utf8)!
        let locations: [Location] = try! JSONDecoder().decode([Location].self, from: list)
        return locations
    }
}

//

//{
//    "name": "大江戸温泉物語",
//    "location": "東京都江東区青海２丁目６−３",
//    "rate": 4.4,
//    "imageURL": "https://static.yukoyuko.net/photo/3739/bath/a0L6F00001FHTTUUA5/1/0001_600.jpg",
//    "tags": ["イルミネーション","ブランド","クリスマス","歩く","ファッション","季節","並木","本","カフェ"]
//},
//{
//    "name": "潮風公園",
//    "location": "東京都品川区東八潮１",
//    "rate": 3.8,
//    "imageURL": "https://www.tokyo-odaiba.net/wp-content/uploads/2018/11/8190abb3413330b64c794f7f00220513-1.jpg",
//    "tags": ["バーベキュー","ポケモン","オリンピック","夜景","ビーチバレー","夕日","船","景観"]
//},
//{
//    "name": "自由の女神像",
//    "location": "東京都港区台場１丁目４ 台場海浜公園内",
//    "rate": 4.3,
//    "imageURL": "https://blog-imgs-42.fc2.com/k/a/z/kazu281/20101221210354691.jpg",
//    "tags": ["ショッピングモール","日没","写真","湾","デートスポット","虹","ライトアップ","観覧車"]
//}
