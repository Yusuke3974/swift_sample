import SwiftUI

struct BookListView: View {
    @Environment(\.​managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Book.timestamp, ascending: false)],
        animation: .default)
    private var books: FetchedResults<Book>

    @State private var showingAddBook = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
                        VStack(alignment: .leading) {
                            Text(book.title ?? "無題")
                                .font(.headline)
                            Text(book.author ?? "著者不明")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("書籍一覧")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBook = true }) {
                        Label("追加", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddBook) {
                AddBookView().environment(\.​managedObjectContext, viewContext)
            }
        }
    }

    private func deleteBooks(offsets: IndexSet) {
        withAnimation {
            offsets.map { books[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("削除エラー: \(error.localizedDescription)")
            }
        }
    }
}
