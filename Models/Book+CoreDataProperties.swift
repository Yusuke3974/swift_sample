import Foundation
import CoreData

extension Book {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var genre: String?
    @NSManaged public var isRead: Bool
    @NSManaged public var rating: Int16
    @NSManaged public var memo: String?
    @NSManaged public var timestamp: Date?
}