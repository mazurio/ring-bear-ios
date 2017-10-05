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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(barButtonItemClicked))
        
        self.navigationItem.setLeftBarButton(closeButton, animated: true)
    }
}

extension ThirdViewController {
    func barButtonItemClicked() {
        self.dismiss(animated: true, completion: nil)
    }
}
