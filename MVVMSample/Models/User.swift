//
//  User.swift
//  MVVMSample
//
//  Created by Nick Lee on 2017/11/1.
//  Copyright © 2017年 Nick Lee. All rights reserved.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let imageUrlString: String
    let email: String
}

extension User {
    
    enum FetchUserError: Error {
        case invalidObject, missingName, missingImageUrl, missingEmail
    }
    
    init(json: Any) throws {

        guard let dictionary = json as? [String: Any] else {
            throw FetchUserError.invalidObject
        }
        
        guard let objectArr = dictionary["results"] as? [Any] else {
            throw FetchUserError.invalidObject
        }
        
        guard let object = objectArr[0] as? [String: Any] else {
            throw FetchUserError.invalidObject
        }
        
        guard let nameDict = object["name"] as? [String: Any] else {
            throw FetchUserError.invalidObject
        }
        
        self.firstName = nameDict["first"] as! String
        self.lastName = nameDict["last"] as! String
        
        guard let imageDict = object["picture"] as? [String: Any] else {
            throw FetchUserError.invalidObject
        }
        
        self.imageUrlString = imageDict["large"] as! String
        self.email = object["email"] as! String
        
    }
}
