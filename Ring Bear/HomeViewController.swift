import UIKit
import Eureka
import RealmSwift

class HomeViewController: FormViewController {
    let realm = try! Realm()

    var header: Header? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        self.createForm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reloadData()
    }
}

extension HomeViewController {
    func createForm() {
        let s = settings()
        
        let headerSection = Section() { section in
            var header = HeaderFooterView<Header>(.nibFile(
                name: "Header",
                bundle: nil
            ))
            
            header.onSetupView = { view, _ in
                self.header = view
            }

            section.header = header
        }
        
        form
            +++ headerSection
            +++ Section("Bride")
            <<< TextRow() {
                $0.title = "Name"
                $0.value = "\(s.brideName)"
                $0.placeholder = "Aldona"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        try! self.realm.write {
                            s.brideName = name
                        }
                        
                        self.reloadData()
                    } else {
                        try! self.realm.write {
                            s.brideName = ""
                        }
                        
                        self.reloadData()
                    }
                }
            }
            +++ Section("Groom")
            <<< TextRow() {
                $0.title = "Name"
                $0.value = "\(s.groomName)"
                $0.placeholder = "Damian"
                $0.onChange { [unowned self] row in
                    if let name = row.value {
                        try! self.realm.write {
                            s.groomName = name
                        }
                        
                        self.reloadData()
                    } else {
                        try! self.realm.write {
                            s.groomName = ""
                        }
                        
                        self.reloadData()
                    }
                }
            }
            +++ Section("Wedding")
            <<< DateRow() {
                $0.title = "Date of the Wedding"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            +++ Section("Guests")
            <<< TextRow() {
                $0.title = "Invited"
                $0.value = "130"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Confirmed"
                $0.value = "97"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Bride"
                $0.value = "10"
                $0.disabled = true
            }
            <<< TextRow() {
                $0.title = "Groom"
                $0.value = "10"
                $0.disabled = true
            }
    }
}

extension HomeViewController {
    func settings() -> Settings {
        let first = realm
            .objects(Settings.self)
            .filter("id == 0")
            .first
        
        if let s = first {
            return s
        } else {
            let s = Settings()
            s.id = 0
            
            try! realm.write {
                realm.add(s)
            }
            
            return s
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.header?.update(settings: self.settings())
        }
    }
}
