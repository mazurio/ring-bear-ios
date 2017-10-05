import UIKit
import Eureka
import RealmSwift

class ThirdViewNavigationController : UINavigationController {}

class ThirdViewController : FormViewController {
    typealias typeCompletionHandler = () -> ()
    var completion: typeCompletionHandler = {}
    
    var currentGuest: Guest = Guest()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createForm()
        
        let cancelButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))
        
        self.navigationItem.setLeftBarButton(cancelButton, animated: true)
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    func onComplete(completionHandler: @escaping typeCompletionHandler) {
        self.completion = completionHandler
    }
}

extension ThirdViewController {
    func createForm() {
        form
            +++ Section()
            <<< TextRow() {
                $0.title = "Name"
                $0.value = self.currentGuest.name
                $0.placeholder = "e.g. Jon"
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
    }
}

extension ThirdViewController {
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
