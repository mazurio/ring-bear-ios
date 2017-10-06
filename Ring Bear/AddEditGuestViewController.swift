import UIKit
import Eureka
import RealmSwift

class AddEditGuestViewNavigationController : UINavigationController {}

class AddEditGuestViewController : FormViewController {
    typealias typeCompletionHandler = () -> ()
    
    var completion: typeCompletionHandler = {}
    
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
    
    func onComplete(completionHandler: @escaping typeCompletionHandler) {
        self.completion = completionHandler
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
                        let realm = try! Realm()
                        try! realm.write {
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
                        let realm = try! Realm()
                        try! realm.write {
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
            <<< PhoneRow() {
                $0.title = "Phone"
                $0.onChange { [unowned self] row in
                    if let phone = row.value {
                        let realm = try! Realm()
                        try! realm.write {
                            self.currentGuest.phone = phone
                        }
                    }
                }
            }
            +++ Section()
            <<< PushRow<String>() {
                $0.title = "Relationship"
                $0.value = "Mutual Guest"
                $0.options = ["Mutual Guest", "Bride", "Groom"]
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        //
                    }
                }
            }
            +++ Section()
            <<< SwitchRow() {
                $0.title = "Invited"
                $0.value = self.currentGuest.invited
                $0.onChange { [unowned self] row in
                    if let invited = row.value {
                        let realm = try! Realm()
                        try! realm.write {
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
                        let realm = try! Realm()
                        try! realm.write {
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
            print("valid?")
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(currentGuest)
            }

            self.dismiss(animated: true, completion: completion)

            print("saving!!!")
        } else {
            print("NOT VALID")
        }
    }
}
