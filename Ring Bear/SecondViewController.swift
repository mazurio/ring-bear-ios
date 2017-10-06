//
//  SecondViewController.swift
//  Ring Bear
//
//  Created by Damian Mazurkiewicz on 09/09/2017.
//  Copyright © 2017 Damian Mazurkiewicz. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UITableViewController {
    
    func listOfGuests() -> Results<Guest> {
        return try! Realm().objects(Guest.self)
    }
    
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
        return listOfGuests().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        let guest = listOfGuests()[indexPath.row]
        
        cell.textLabel?.text = "\(guest.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "ThirdViewNavigationController") as! ThirdViewNavigationController
        
        let controller = destination.topViewController as! ThirdViewController
        
        let guest = listOfGuests()[indexPath.row]
        controller.currentGuest = guest
        controller.title = "Edit Guest"
        controller.onComplete() { () in
            self.reloadData()
        }
        
        navigationController?.present(destination, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let guestToBeDeleted = listOfGuests()[indexPath.row]
            
            let realm = try! Realm()
            try! realm.write {
                realm.delete(guestToBeDeleted)
            }
        
            self.reloadData()
        }
    }
}

extension SecondViewController {
    func addGuest() {
        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "ThirdViewNavigationController") as! ThirdViewNavigationController
        
        let controller = destination.topViewController as! ThirdViewController
        controller.title = "Add Guest"
        controller.onComplete() { () in
            self.reloadData()
        }
        
        navigationController?.present(destination, animated: true, completion: nil)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
