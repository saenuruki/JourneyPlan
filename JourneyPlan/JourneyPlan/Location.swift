//
//  Location.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/25.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import Foundation

struct Location: Codable {
    var name: String
    var location: String
    var rate: Float
    var imageURL: String
    var tags: [String]

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
            "name": "船の科学館",
            "location": "東京都品川区東八潮３丁目１",
            "rate": 3.5,
            "imageURL": "https://media-cdn.tripadvisor.com/media/photo-m/1280/1b/26/26/69/a-closed-museum.jpg",
            "tags": ["子供","歴史","工事","トイレ","小学校","係留施設","9月30日","散策","日本化学未来館","オリンピック"]
        }]
        """.data(using: .utf8)!
        let locations: [Location] = try! JSONDecoder().decode([Location].self, from: list)
        return locations
    }
}

