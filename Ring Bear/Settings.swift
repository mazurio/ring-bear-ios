import RealmSwift

class Settings: Object {
    dynamic var id = 0
    
    dynamic var brideName: String = ""
    dynamic var groomName: String = ""
    
    dynamic var weddingDate: Date? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
