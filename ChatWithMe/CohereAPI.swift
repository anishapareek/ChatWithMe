//
//  CohereAPI.swift
//  Chat With Me
//
//  Created by Anisha Pareek
//

import Foundation

struct CohereAPI {
    static let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath),
              let key = plist["COHERE_API_KEY"] as? String else {
            fatalError("Couldn't find key 'COHERE_API_KEY' in 'Secrets.plist'.")
        }
        return key
    }()
    static let endpoint = "https://api.cohere.ai/v1/chat"

    static func sendMessage(message: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: endpoint) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let parameters: [String: Any] = [
            "message": message
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let response = jsonResponse["text"] as? String {
                    DispatchQueue.main.async {
                        completion(response)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}

