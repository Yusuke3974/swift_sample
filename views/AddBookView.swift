import SwiftUI

struct AddBookView: View {
    @Environment(\.​managedObjectContext) private var viewContext
    @Environment(\.​dismiss) private var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var isRead = false
    @State private var rating = 3
    @State private var memo = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("書籍情報")) {
                    TextField("タイトル", text: $title)
                    TextField("著者", text: $author)
                    TextField("ジャンル", text: $genre)
                }
                Section(header: Text("その他")) {
                    Toggle("読了", isOn: $isRead)
                    Stepper("評価: \(rating)", value: $rating, in: 1...5)
                    TextField("メモ", text: $memo)
                }
            }
            .navigationTitle("書籍を追加")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") { addBook() }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") { dismiss() }
                }
            }
        }
    }

    private func addBook() {
        let newBook = Book(context: viewContext)
        newBook.title = title
        newBook.author = author
        newBook.genre = genre
        newBook.isRead = isRead
        newBook.rating = Int16(rating)
        newBook.memo = memo
        newBook.timestamp = Date()

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("保存失敗: \(error.localizedDescription)")
        }
    }
}