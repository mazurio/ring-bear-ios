import RealmSwift

class Guest: Object {
    dynamic var name = ""
    dynamic var surname = ""
    dynamic var phone = ""
    
    dynamic var invited = false
    dynamic var acceptedInvitation = false
}

class Settings: Object {
    dynamic var id = 0
    
    dynamic var brideName: String? = nil
    dynamic var groomName: String? = nil
    
    dynamic var weddingDate: Date? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
