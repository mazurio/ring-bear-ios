//
//  ThirdViewController.swift
//  Ring Bear
//
//  Created by Damian Mazurkiewicz on 05/10/2017.
//  Copyright © 2017 Damian Mazurkiewicz. All rights reserved.
//

import UIKit
import Eureka

class ThirdViewNavigationController : UINavigationController {}

class ThirdViewController : FormViewController {
    var currentGuest: Guest? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createForm()
        
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
}

extension ThirdViewController {
    func createForm() {
        form
            +++ Section()
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "e.g. Jon"
                $0.onChange { [unowned self] row in
                    // self.viewModel.title = row.value
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.cellUpdate { (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            +++ Section()
            <<< PushRow<String>() {
                $0.title = "Repeats"
                $0.options = ["1", "2"]
                $0.onChange { [unowned self] row in
                    
                }
            }
            +++ Section()
            <<< SegmentedRow<String>() {
                $0.title = "Priority"
                $0.options = ["!", "!!", "!!!"]
                $0.onChange { [unowned self] row in
                    
                }
        }
    }
}


extension ThirdViewController {
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func save() {
        if form.validate().isEmpty {
            print("saving!!!")
        } else {
            print("NOT VALID")
        }
    }
}
