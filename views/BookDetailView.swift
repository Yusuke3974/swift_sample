import SwiftUI

struct BookDetailView: View {
    var book: Book

    var body: some View {
        Form {
            Section(header: Text("基本情報")) {
                Text("タイトル: \(book.title ?? "")")
                Text("著者: \(book.author ?? "")")
                Text("ジャンル: \(book.genre ?? "")")
            }
            Section(header: Text("詳細")) {
                Text("読了: \(book.isRead ? "はい" : "いいえ")")
                Text("評価: \(book.rating)/5")
                Text("メモ: \(book.memo ?? "")")
            }
        }
        .navigationTitle("書籍詳細")
    }
}