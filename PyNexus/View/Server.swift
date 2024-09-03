//
//  Server.swift
//  PyNexus
//
//  Created by patron on 23/02/2024.
//

import Foundation

func sendScriptToServer(script: String, completion: @escaping (String) -> Void) {
    var request = URLRequest(url: URL(string: "https://NoamF.pythonanywhere.com/runscript")!)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = ["script": script]
    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Check for errors
        if let error = error {
            completion("Request error:\(error)")
            return
        }
        
        // Ensure there is data in the response
        guard let data = data else {
            completion("No data in response")
            return
        }
        
        if let rawResponse = String(data: data, encoding: .utf8) {
            completion("Raw server response: \(rawResponse)")
        }
        
        // Parse the JSON data
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let output = jsonResponse["output"] as? String {
                DispatchQueue.main.async {
                    completion(output)
                }
            } else {
                DispatchQueue.main.async {
                    completion("Error: Expected 'output' key not found in the response.")
                }
            }
        } catch let parsingError {
            DispatchQueue.main.async {
                completion("Error parsing JSON: \(parsingError)")
            }
        }
    }
    task.resume()
}

struct ServerResponse: Decodable {
    var error: String?
    var output: String
}
