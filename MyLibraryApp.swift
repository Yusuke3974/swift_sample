import SwiftUI

@main
struct MyLibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BookListView()
                .environment(\.​managedObjectContext, persistenceController.container.viewContext)
        }
    }
}