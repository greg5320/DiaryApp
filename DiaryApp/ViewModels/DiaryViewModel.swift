
import Foundation
import SwiftUI

class DiaryViewModel: ObservableObject{
    @Published var entries:[DiaryEntry] = []
    private let fileName = "diary_entries.json"
    
    init(){
        loadEntries()
    }
    
    func addEntry(content: String){
        let newDiaryEntry:DiaryEntry = DiaryEntry(id: UUID(), date: Date(), content: content)
        
        entries.insert(newDiaryEntry,at: 0)
        saveEntries()
    }
    
    func updateEntry(id:UUID, content:String){
        if let index = entries.firstIndex(where: {$0.id == id}){
            entries[index].content = content
            saveEntries()
        }
    }
    
    private func getFileURL() -> URL? {
        let fm = FileManager.default
        guard let docs = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return docs.appendingPathComponent(fileName)
    }
    
    private func saveEntries(){
        guard let url = getFileURL() else { return }
        do {
            let data = try JSONEncoder().encode(entries)
            try data.write(to: url)
            print("Data successfully saved")
        }
        catch{
            print("Error while saving")
        }
    }
    
    private func loadEntries(){
        guard let url = getFileURL() else { return }
        do{
            let data = try Data(contentsOf: url)
            let decodedEntries = try JSONDecoder().decode([DiaryEntry].self, from: data)
            self.entries = decodedEntries
            print("Load success")
        }
        catch{
            print("Load failed")
        }
    }
    
    func deleteEntry(at offsets: IndexSet){
        entries.remove(atOffsets: offsets)
        saveEntries()
    }
}
