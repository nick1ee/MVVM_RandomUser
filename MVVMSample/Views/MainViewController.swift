//
//  MainViewController.swift
//  MVVMSample
//
//  Created by Nick Lee on 2017/11/1.
//  Copyright © 2017年 Nick Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!

    fileprivate let viewModel = UserViewModel(with: DataService())
    
    @IBAction func reloadBtn(_ sender: UIButton) {
        viewModel.fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataBinding()
        viewModel.fetchData()
    }
    
    deinit {
        viewModel.removeObserver(self, forKeyPath: "isReadyForNewUser")
    }
    
    private func configDataBinding() {
        viewModel.addObserver(self, forKeyPath:"isReadyForNewUser", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "isReadyForNewUser" {
            userNameLabel.text = viewModel.userName
            userEmailLabel.text = viewModel.userEmail
            getDataFromUrl(urlString: viewModel.userImageUrlString)
        }
    }
    
    private func getDataFromUrl(urlString: String) {
        let url = URL(string: urlString)!
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.userImageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

}
