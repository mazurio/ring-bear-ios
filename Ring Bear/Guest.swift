import RealmSwift

class Guest: Object {
    dynamic var name = ""
    dynamic var surname = ""
    dynamic var phone = ""
    
    dynamic var invited = false
    dynamic var acceptedInvitation = false
}

class Settings: Object {
    dynamic var brideName = ""
    dynamic var groomName = ""
}
