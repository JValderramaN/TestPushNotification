//
//  ViewController.swift
//  TestPushNotification
//
//  Created by Momentum Lab 4 on 3/22/17.
//  Copyright © 2017 JoseValderrama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.getDetailFromUserDefaults), name: .onDidReceivedPushNotification, object: nil)
        getDetailFromUserDefaults()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func getDetailFromUserDefaults(){
        let defaults = UserDefaults.standard
        detailLabel.text = defaults.string(forKey: kDetail) ?? "Empty Value"
    }
}

