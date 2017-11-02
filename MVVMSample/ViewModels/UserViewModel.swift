//
//  UserViewModel.swift
//  MVVMSample
//
//  Created by Nick Lee on 2017/11/1.
//  Copyright © 2017年 Nick Lee. All rights reserved.
//

import Foundation

class UserViewModel: NSObject {
    
    private(set) var userName: String = ""
    private(set) var userEmail: String = ""
    private(set) var userImageUrlString: String = ""
    private(set) var user: User? {
        didSet {
            self.userEmail = user!.email
            self.userImageUrlString = user!.imageUrlString
            self.userName = "\(user!.firstName) \(user!.lastName)"
            self.isReadyForNewUser = true
        }
    }
    
    @objc dynamic var isReadyForNewUser: Bool = false
    
    fileprivate let dataService: DataService
    
    init(with dataService: DataService) {
        self.dataService = dataService
        super.init()
    }
    
    func fetchData() {
        dataService.requestRandomUser { (user) in
            DispatchQueue.main.async {
                self.user = user
            }
        }
    }
    
}
