import UIKit
import RealmSwift

class GuestListViewController: UITableViewController {
    func listOfGuests() -> Results<Guest> {
        return try! Realm().objects(Guest.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Guest List"
        
        let addGuestButton = UIBarButtonItem(
            image: UIImage(named: "add_guest")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(addGuest)
        )
        
        self.navigationItem.setRightBarButton(addGuestButton, animated: true)
    }
}

extension GuestListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfGuests().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        let guest = listOfGuests()[indexPath.row]
        
        cell.textLabel?.text = "\(guest.name) \(guest.surname)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "AddEditGuestViewNavigationController") as! AddEditGuestViewNavigationController
        
        let controller = destination.topViewController as! AddEditGuestViewController
        
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

extension GuestListViewController {
    func addGuest() {
        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "AddEditGuestViewNavigationController") as! AddEditGuestViewNavigationController
        
        let controller = destination.topViewController as! AddEditGuestViewController
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
