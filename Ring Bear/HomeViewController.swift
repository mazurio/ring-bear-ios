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
            <<< TextRow("numberOfGuests") {
                $0.title = "Total"
                $0.value = "\(numberOfGuests())"
                $0.disabled = true
            }
            <<< TextRow("numberOfInvitedGuests") {
                $0.title = "Invited"
                $0.value = "\(numberOfInvitedGuests())"
                $0.disabled = true
            }
            <<< TextRow("numberOfGuestsWhoAcceptedInvitation") {
                $0.title = "Confirmed"
                $0.value = "\(numberOfGuestsWhoAcceptedInvitation())"
                $0.disabled = true
            }
            <<< TextRow("numberOfMutualGuests") {
                $0.title = "Mutual Guests"
                $0.value = "\(numberOfMutualGuests())"
                $0.disabled = true
            }
            <<< TextRow("numberOfGuestsOfTheBride") {
                $0.title = "Guests of the Bride"
                $0.value = "\(numberOfGuestsOfTheBride())"
                $0.disabled = true
            }
            <<< TextRow("numberOfGuestsOfTheGroom") {
                $0.title = "Guests of the Groom"
                $0.value = "\(numberOfGuestsOfTheGroom())"
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
    
    func numberOfGuests() -> Int {
        return realm.objects(Guest.self).count
    }
    
    func numberOfInvitedGuests() -> Int {
        return realm.objects(Guest.self)
            .filter("invited == true")
            .count
    }
    
    func numberOfGuestsWhoAcceptedInvitation() -> Int {
        return realm.objects(Guest.self)
            .filter("acceptedInvitation == true")
            .count
    }
    
    func numberOfMutualGuests() -> Int {
        return realm.objects(Guest.self)
            .filter("relationship == 'mutual'")
            .count
    }
    
    func numberOfGuestsOfTheBride() -> Int {
        return realm.objects(Guest.self)
            .filter("relationship == 'bride'")
            .count
    }
    
    func numberOfGuestsOfTheGroom() -> Int {
        return realm.objects(Guest.self)
            .filter("relationship == 'groom'")
            .count
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.header?.update(settings: self.settings())
            
            let numberOfGuestsRow: TextRow? = self.form.rowBy(tag: "numberOfGuests")
            numberOfGuestsRow?.value = "\(self.numberOfGuests())"
            numberOfGuestsRow?.updateCell()
            
            let numberOfGuestsWhoAcceptedInvitationRow: TextRow? = self.form.rowBy(tag: "numberOfGuestsWhoAcceptedInvitation")
            numberOfGuestsWhoAcceptedInvitationRow?.value = "\(self.numberOfGuestsWhoAcceptedInvitation())"
            numberOfGuestsWhoAcceptedInvitationRow?.updateCell()
            
            let numberOfInvitedGuestsRow: TextRow? = self.form.rowBy(tag: "numberOfInvitedGuests")
            numberOfInvitedGuestsRow?.value = "\(self.numberOfInvitedGuests())"
            numberOfInvitedGuestsRow?.updateCell()

            let numberOfMutualGuestsRow: TextRow? = self.form.rowBy(tag: "numberOfMutualGuests")
            numberOfMutualGuestsRow?.value = "\(self.numberOfMutualGuests())"
            numberOfMutualGuestsRow?.updateCell()
            
            let numberOfGuestsOfTheBrideRow: TextRow? = self.form.rowBy(tag: "numberOfGuestsOfTheBride")
            numberOfGuestsOfTheBrideRow?.value = "\(self.numberOfGuestsOfTheBride())"
            numberOfGuestsOfTheBrideRow?.updateCell()
            
            let numberOfGuestsOfTheGroomRow: TextRow? = self.form.rowBy(tag: "numberOfGuestsOfTheGroom")
            numberOfGuestsOfTheGroomRow?.value = "\(self.numberOfGuestsOfTheGroom())"
            numberOfGuestsOfTheGroomRow?.updateCell()
        }
    }
}
