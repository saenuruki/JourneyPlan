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
    var tagsStr: String
}

