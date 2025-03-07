
import Foundation
import SwiftUI

struct NewDiaryEntryView: View {
    @ObservedObject var viewModel: DiaryViewModel
    @State private var content:String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var diaryEntry:DiaryEntry? = nil
    var body: some View {
        VStack{
            TextEditor(text: $content)
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
//                .background(Color("PaperColor"))
                .border(Color.brown, width: 1)
            Button("Save"){
                
                if let existingEntry = diaryEntry {
                    viewModel.updateEntry(id: existingEntry.id, content: content)
                    presentationMode.wrappedValue.dismiss()
                }
                else{
                    //                    guard !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                    //                        print("Text is null so entry not added")
                    //                        return
                    //                    }
                    viewModel.addEntry(content: content)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
            .background(Color("PaperColor"))
            Spacer()
            
        }
        .background(Color("PaperColor"))
        .navigationBarTitle(diaryEntry == nil ? "New note" : "Edit Note", displayMode: .inline)
        .onAppear(){
            if let existingEntry = diaryEntry{
                content = existingEntry.content
            }
        }
    }
}


struct NewDiaryEntryView_Previews: PreviewProvider{
    static var previews: some View{
        NewDiaryEntryView(viewModel:DiaryViewModel())
    }
}
