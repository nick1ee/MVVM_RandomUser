//
//  DataService.swift
//  MVVMSample
//
//  Created by Nick Lee on 2017/11/1.
//  Copyright © 2017年 Nick Lee. All rights reserved.
//

import UIKit

class DataService: NSObject {
    
    let baseUrl = URL(string: "https://randomuser.me/api/")

    func requestRandomUser(completionHandler: @escaping (User) -> Void) {
        let request = URLRequest(url: baseUrl!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    let user = try User(json: json)
                    completionHandler(user)
                } catch let error {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
