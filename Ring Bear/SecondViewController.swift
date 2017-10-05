//
//  SecondViewController.swift
//  Ring Bear
//
//  Created by Damian Mazurkiewicz on 09/09/2017.
//  Copyright © 2017 Damian Mazurkiewicz. All rights reserved.
//

import UIKit

class SecondViewController: UITableViewController {
    let listOfGuests = [
        Guest(name: "Damian"),
        Guest(name: "Marek")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addGuestButton = UIBarButtonItem(title: "Add Guest", style: .plain, target: self, action: #selector(addGuest))
        self.navigationItem.setRightBarButton(addGuestButton, animated: true)
    }
}

extension SecondViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfGuests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        let guest = listOfGuests[indexPath.row]
        
        cell.textLabel?.text = "\(guest.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "ThirdViewNavigationController") as! ThirdViewNavigationController
        
        let controller = destination.topViewController as! ThirdViewController
        
        let guest = listOfGuests[indexPath.row]
        controller.currentGuest = guest
        
        navigationController?.present(destination, animated: true, completion: nil)
    }
}

extension SecondViewController {
    func addGuest() {
        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "ThirdViewNavigationController") as! ThirdViewNavigationController
        
        let controller = destination.topViewController as! ThirdViewController
        
        navigationController?.present(destination, animated: true, completion: nil)
    }
}
