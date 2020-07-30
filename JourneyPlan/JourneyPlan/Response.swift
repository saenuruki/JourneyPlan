//
//  Response.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/30.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import Foundation

struct NLPResponse: Codable {
    let entities: [Entity]
    let language: String
}

struct Entity: Codable {
    let name: String
    let type: String
    let metadata: [String: String]
    let salience: Int
    let mentions: [EntityMention]
    let sentiment: Sentiment?
}

struct EntityMention: Codable {
    let text: TextSpan
    let type: String
    let sentiment: Sentiment?

}

struct TextSpan: Codable {
    let content: String
    let beginOffset: Int
}

struct Sentiment: Codable {
    let magnitude: Int
    let score: Int
}
