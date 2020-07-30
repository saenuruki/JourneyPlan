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
        print(locationList)
    }
    
    func searchLocation() {
        
        GoogleNLPRequest.getEntities(with: inputTexts.value, complation: { [weak self] entities in
            guard let wself = self else { return }
            
            if entities.isEmpty { return }
            
            var recomendLocations: [Location] = []
            entities.forEach{ entity in
                let filteredLocations = wself.locationList.filter{ $0.tagsStr.contains(entity.name) } // entity
                recomendLocations.append(contentsOf: filteredLocations)
            }
            print("＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝")
            print(recomendLocations)
            DispatchQueue.main.async {
                wself.locationTrigger.onNext(recomendLocations)
            }
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
            "tagsStr": "観光客,仲見世,スカイツリー,おみくじ,ライトアップ,提灯,人力車,屋台,文化"
        },
        {
            "name": "船の科学館",
            "location": "東京都品川区東八潮３丁目１",
            "rate": 3.5,
            "imageURL": "https://media-cdn.tripadvisor.com/media/photo-m/1280/1b/26/26/69/a-closed-museum.jpg",
            "tagsStr": "子供,歴史,工事,トイレ,小学校,係留施設,9月30日,散策,日本化学未来館,オリンピック"
        },
        {
            "name": "フジテレビジョン",
            "location": "東京都港区台場２丁目４−８",
            "rate": 3.8,
            "imageURL": "https://stat.ameba.jp/user_images/20180810/19/w3t6t2pmaj/8f/e7/j/o0768051214245148218.jpg?caw=800",
            "tagsStr": "イベント,展望台,建築,アニメ,夏休み,ドラゴンボール,アナウンサー,芸能人,修学旅行"
        },
        {
            "name": "大江戸温泉物語",
            "location": "東京都江東区青海２丁目６−３",
            "rate": 4.4,
            "imageURL": "https://static.yukoyuko.net/photo/3739/bath/a0L6F00001FHTTUUA5/1/0001_600.jpg",
            "tagsStr": "ウェルネス,フィットネス,スパ,浴衣,食事,家族,雰囲気"
        },
        {
            "name": "潮風公園",
            "location": "東京都品川区東八潮１",
            "rate": 3.8,
            "imageURL": "https://www.tokyo-odaiba.net/wp-content/uploads/2018/11/8190abb3413330b64c794f7f00220513-1.jpg",
            "tagsStr": "バーベキュー,ポケモン,オリンピック,夜景,ビーチバレー,夕日,船,景観"
        },
        {
            "name": "自由の女神像",
            "location": "東京都港区台場１丁目４ 台場海浜公園内",
            "rate": 4.3,
            "imageURL": "https://blog-imgs-42.fc2.com/k/a/z/kazu281/20101221210354691.jpg",
            "tagsStr": "ショッピングモール,日没,写真,湾,デートスポット,虹,ライトアップ,観覧車"
        },
        {
            "name": "うんこミュージアム",
            "location": "東京都江東区青海１丁目１−１０",
            "rate": 3.8,
            "imageURL": "https://static.retrip.jp/spot/cadf7023-7de8-405a-b8cf-d385e0b670b1/images/377f0f8e-e1e1-4c38-85e7-b1b3f54e5cd9_m.jpg",
            "tagsStr": "インスタ,写真,休み,企画,チケット"
        },
        {
            "name": "東京スカイツリー",
            "location": "東京都墨田区押上１丁目１−２",
            "rate": 4.4,
            "imageURL": "https://www.tokyo-solamachi.jp/enjoy/spot/img/img-skytree-spot-02.png",
            "tagsStr": "ショッピングモール,ライトアップ,水族館,プラネタリウム,タワー"
        },
        {
            "name": "東京タワー",
            "location": "東京都港区芝公園４丁目２−８",
            "rate": 4.4,
            "imageURL": "https://www.knt.co.jp/tabiplanet/image/kokunai_200221_26.jpg",
            "tagsStr": "お土産,ライトアップ,ブリ,イルミネーション,ツアー,看板,修学旅行"
        },
        {
            "name": "東京ディズニーランド",
            "location": "千葉県浦安市舞浜１−１",
            "rate": 4.6,
            "imageURL": "https://www.tokyodisneyresort.jp/var/rev0/0003/2840/main-og.jpg",
            "tagsStr": "パレード,ファストパス,ディズニーシー,ミッキー,スペースマウンテン,プロジェクションマッピング"
        },
        {
            "name": "明治神宮",
            "location": "東京都渋谷区代々木神園町１−１",
            "rate": 4.6,
            "imageURL": "https://upload.wikimedia.org/wikipedia/commons/e/ed/Courtyard_of_Meiji_Shrine_20190717.jpg",
            "tagsStr": "歩く,森,結婚式,平和,都心,尊敬"
        },
        {
            "name": "皇居",
            "location": "東京都千代田区千代田１−１",
            "rate": 4.4,
            "imageURL": "https://anaintercontinental-tokyo.jp/wp-content/uploads/2018/07/Imperial_Palace.jpg",
            "tagsStr": "歩く,桜,散歩,紅葉,ランニング,陛下,堀,皇帝,スマホアプリ"
        },
        {
            "name": "上野恩賜公園",
            "location": "東京都台東区上野公園８−・ 池之端三丁目",
            "rate": 4.3,
            "imageURL": "https://tripeditor.com/wp-content/uploads/2020/03/10160552/shutterstock_405603244-1-1200x800.jpg",
            "tagsStr": "桜,美術館,花見,パンダ,不忍池,蓮,聖堂,大道芸"
        },
        {
            "name": "新宿御苑",
            "location": "東京都新宿区内藤町１１",
            "rate": 4.5,
            "imageURL": "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/03/a0003755/img/basic/a0003755_main.jpg?20200415185118&q=80&rw=750&rh=536",
            "tagsStr": "桜,温室,花見,日本庭園,都心,四季,バラ園"
        },
        {
            "name": "表参道",
            "location": "東京都港区南青山５丁目 １",
            "rate": 4.4,
            "imageURL": "https://www.borderless-house.jp/images/houselist/station/omotesando/omotesando1.jpg",
            "tagsStr": "イルミネーション,ブランド,クリスマス,歩く,ファッション,季節,並木,本,カフェ"
        },
        {
            "name": "六本木ヒルズ",
            "location": "東京都港区六本木６丁目１０−１",
            "rate": 4.2,
            "imageURL": "https://www.tokyoweekender.com/wp-content/uploads/2017/03/roppongi-hills.png",
            "tagsStr": "展望台,美術館,イベント,映画館,イルミネーション,屋上,展覧会,ブランド"
        },
        {
            "name": "竹下通り",
            "location": "東京都渋谷区神宮前１丁目１７",
            "rate": 4.1,
            "imageURL": "https://spi-ra.jp/wp-content/uploads/2019/08/34825434_m-1080x720.jpg",
            "tagsStr": "クレープ,ファッション,お土産,青年期,集団,綿あめ,可愛い,コスプレ"
        },
        {
            "name": "アメヤ横丁",
            "location": "東京都台東区上野４丁目９−１４",
            "rate": 4.1,
            "imageURL": "https://dsimg.wowjpn.goo.ne.jp/rs/?src=https://wow-j.com/images/ext/allguides/01083/01083_001.jpg&maxw=750&maxh=0&resize=1",
            "tagsStr": "外国人,お土産,ケバブ,年末,屋台,観光客,魚屋"
        }
        ]
        """.data(using: .utf8)!
        let locations: [Location] = try! JSONDecoder().decode([Location].self, from: list)
        return locations
    }
}

extension Array where Element: Equatable {
  var unique: [Element] {
    return reduce([Element]()) { $0.contains($1) ? $0 : $0 + [$1] }
  }
}
