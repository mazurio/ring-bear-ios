//
//  SecondViewController.swift
//  Ring Bear
//
//  Created by Damian Mazurkiewicz on 09/09/2017.
//  Copyright © 2017 Damian Mazurkiewicz. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SecondViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ThirdViewNavigationController") as! ThirdViewNavigationController
        
        navigationController?.present(destination, animated: true, completion: nil)
//        navigationController?.pushViewController(destination, animated: true)
        
    }
}

