//
//  Response.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/30.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import Foundation

struct NLPResponse: Codable {
    var entities: [Entity]
    var language: String = ""
}

struct Entity: Codable {
    var name: String = ""
    var type: String = ""
    var metadata: [String: String]
    var salience: Float = 0
    var mentions: [EntityMention]
    var sentiment: Sentiment?
}

struct EntityMention: Codable {
    var text: TextSpan
    var type: String = ""
    var sentiment: Sentiment?

}

struct TextSpan: Codable {
    var content: String = ""
    var beginOffset: Int = 0
}

struct Sentiment: Codable {
    var magnitude: Int = 0
    var score: Int = 0
}
