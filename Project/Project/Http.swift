//
//  http.swift
//  Project
//
//  Created by formando on 11/12/2019.
//  Copyright © 2019 ipleiria. All rights reserved.
//

import Foundation
import UIKit

class Launch: Codable {
    let userId: Int
    let id: Int
    let title: String
    
    init(userId: Int, id: Int, title: String) {
        self.userId = userId
        self.id = id
        self.title = title
    }
}

final class Http {
    static func get(){
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                print("GET");
                  do {
                     let res = try JSONDecoder().decode(Launch.self, from: data)
                     print(res.id)
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }
    
    static func post(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(Launch(userId: 1, id: 1, title: "eee"))
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("POST");
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    static func put(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = try! JSONEncoder().encode(Launch(userId: 1, id: 1, title: "eee"))
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("PUT");
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                }
            }
        }
        task.resume()
    }
    
    static func delete(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("DELETE");
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}
