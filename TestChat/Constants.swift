

struct Constants {
   static let titleLabel = "🔨TestChat"
   static let loginSegue = "LoginToChat"
   static let registerSegue = "RegisterToChat"
    static let cellNibName = "NewMessageCell"
    static let cellIdentifier = "ReusableCell"
    
    struct FireStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
}
