//
//  ThirdViewController.swift
//  Ring Bear
//
//  Created by Damian Mazurkiewicz on 05/10/2017.
//  Copyright © 2017 Damian Mazurkiewicz. All rights reserved.
//

import UIKit

class ThirdViewNavigationController : UINavigationController {}

class ThirdViewController : UIViewController {
    var currentGuest: Guest? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
}

extension ThirdViewController {
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func save() {
        print("save")
    }
}
