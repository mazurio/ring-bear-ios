import UIKit
import RealmSwift

class GuestListViewController: UITableViewController {
    let realm = try! Realm()

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reloadData()
    }
}

extension GuestListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = listOfGuests().count
        
        if count == 0 {
            self.tableView.setEmptyMessage("Start your guest list by inviting your first guest with the '+' button.")
        } else {
            self.tableView.restore()
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Our Guests"
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
    func listOfGuests() -> Results<Guest> {
        return realm
            .objects(Guest.self)
            .sorted(byKeyPath: "name")
    }
    
    func addGuest() {
        let storyboard = UIStoryboard(name: "AddEditGuest", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(
            withIdentifier: "AddEditGuestViewNavigationController") as! AddEditGuestViewNavigationController
        
        let controller = destination.topViewController as! AddEditGuestViewController
        controller.title = "Add Guest"
        
        navigationController?.present(destination, animated: true, completion: nil)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
