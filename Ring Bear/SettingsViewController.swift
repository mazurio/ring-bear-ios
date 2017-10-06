import UIKit
import Eureka

class SettingsViewController : FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createForm()
        
        self.title = "Settings"
    }
}

extension SettingsViewController {
    func createForm() {
        
        form
            +++ Section("Bride")
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Aldona"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
//                        let realm = try! Realm()
//                        try! realm.write {
//                            self.currentGuest.name = name
//                        }
                    }
                }
            }
            <<< TextRow() {
                $0.title = "Surname"
                $0.placeholder = "Stojak"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        //                        let realm = try! Realm()
                        //                        try! realm.write {
                        //                            self.currentGuest.name = name
                        //                        }
                    }
                }
            }
            +++ Section("Groom")
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Damian"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                    
                    }
                }
            }
            <<< TextRow() {
                $0.title = "Surname"
                $0.placeholder = "Mazurkiewicz"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        //                        let realm = try! Realm()
                        //                        try! realm.write {
                        //                            self.currentGuest.name = name
                        //                        }
                    }
                }
            }
            +++ Section("Wedding")
            <<< DateRow() {
                $0.title = "Date of the Wedding"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
        

    }
}
