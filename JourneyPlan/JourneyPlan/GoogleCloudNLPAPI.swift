//
//  GoogleCloudNLPAPI.swift
//  JourneyPlan
//
//  Created by 塗木冴 on 2020/07/30.
//  Copyright © 2020 塗木冴. All rights reserved.
//

import Foundation

struct GoogleNLPRequest {
    
    static let session = URLSession.shared
    static let googleAPIKey = "AIzaSyDV5UNPOj3y2cVZSSbhtKUeNLJupbAtdK0"
    static var googleURL: URL {
        return URL(string: "https://language.googleapis.com/v1/documents:analyzeEntities?key=\(googleAPIKey)")!
    }
    
    static func getEntities(with content: String, complation: @escaping ([Entity]) -> Void) {
        let method = "POST"
        let body: [String: Any] = [
            "document": [
               "type": "PLAIN_TEXT",
               "language": "JA",
               "content": content
            ],
            "encodingType": "UTF8"
        ]
        let httpBody: Data? = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        var urlRequest = URLRequest(url: googleURL)
        urlRequest.httpMethod = method
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        urlRequest.httpBody = httpBody
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil, let data = data {
                do {
                    let json = try JSONDecoder().decode(NLPResponse.self, from: data)
                    complation(json.entities)
                } catch let error {
                   print("Error = \(error)")
                }
            }
        }.resume()
    }
}
