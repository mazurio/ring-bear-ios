import UIKit
import Eureka
import RealmSwift

class AddEditGuestViewNavigationController : UINavigationController {}

class AddEditGuestViewController : FormViewController {
    let realm = try! Realm()
    
    var currentGuest: Guest = Guest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createForm()
        
        let cancelButton = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(cancel)
        )
        
        let saveButton = UIBarButtonItem(
            title: "Save",
            style: .plain,
            target: self,
            action: #selector(save)
        )
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
}

extension AddEditGuestViewController {
    func createForm() {
        form
            +++ Section()
            <<< TextRow() {
                $0.title = "Name"
                $0.value = self.currentGuest.name
                $0.placeholder = "Jon"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        try! self.realm.write {
                            self.currentGuest.name = name
                        }
                    }
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.cellUpdate { (cell, row) in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< TextRow() {
                $0.title = "Surname"
                $0.value = self.currentGuest.surname
                $0.placeholder = "Snow"
                $0.onChange { [unowned self] row in
                    if let surname = row.value {
                        try! self.realm.write {
                            self.currentGuest.surname = surname
                        }
                    }
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
                $0.title = "Relationship"
                $0.value = self.relationshipToTitle()
                $0.options = ["Mutual Guest", "Bride", "Groom"]
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        try! self.realm.write {
                            if value == "Mutual Guest" {
                                self.currentGuest.relationship = "mutual"
                            } else if value == "Bride" {
                                self.currentGuest.relationship = "bride"
                            } else if value == "Groom" {
                                self.currentGuest.relationship = "groom"
                            } else {
                                self.currentGuest.relationship = ""
                            }
                        }
                    }
                }
            }
            +++ Section()
            <<< SwitchRow() {
                $0.title = "Invited"
                $0.value = self.currentGuest.invited
                $0.onChange { [unowned self] row in
                    if let invited = row.value {
                        try! self.realm.write {
                            self.currentGuest.invited = invited
                        }
                    }
                }
            }
            <<< SwitchRow() {
                $0.title = "Accepted Invitation"
                $0.value = self.currentGuest.acceptedInvitation
                $0.onChange { [unowned self] row in
                    if let acceptedInvitation = row.value {
                        try! self.realm.write {
                            self.currentGuest.acceptedInvitation = acceptedInvitation
                        }
                    }
                }
            }
        
    }
}

extension AddEditGuestViewController {
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func save() {
        if form.validate().isEmpty {
            try! realm.write {
                realm.add(currentGuest)
            }

            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func relationshipToTitle() -> String {
        if self.currentGuest.relationship == "groom" {
            return "Groom"
        } else if self.currentGuest.relationship == "bride" {
            return "Bride"
        } else {
            return "Mutual Guest"
        }
    }
}
