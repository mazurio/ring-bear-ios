import UIKit
import Eureka

class HomeViewController: FormViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.createForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("appear")
    }
}

extension HomeViewController {
    func createForm() {
        
        let headerSection = Section() { section in
            var header = HeaderFooterView<Header>(.nibFile(name: "Header", bundle: nil))

            section.header = header
        }
        
        form
            +++ headerSection
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
            +++ Section("Statistics")
            <<< TextRow() {
                $0.title = "Number of invited guests"
                $0.value = "130"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Number of confirmed invitations"
                $0.value = "97"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Guests of the Bride"
                $0.value = "10"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Guests of the Groom"
                $0.value = "10"
                $0.disabled = true
            }
        
    }
}
