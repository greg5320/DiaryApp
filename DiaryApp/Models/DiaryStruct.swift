
import Foundation

struct DiaryEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    var content: String
}
