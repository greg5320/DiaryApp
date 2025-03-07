
import Foundation
import SwiftUI

struct DiaryListView: View {
    @StateObject var viewModel = DiaryViewModel()
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundColor = UIColor.clear
    }
    var body: some View {
        
        NavigationView{
            List{
                ForEach(viewModel.entries){ entry in
                    NavigationLink(destination: NewDiaryEntryView(viewModel: viewModel, diaryEntry:entry)){
                        ZStack(alignment: .leading){
                            RoundedRectangle(cornerRadius: 10) .fill(Color("CellColor"))
                            
                            VStack(alignment: .leading) {
                                Text(entry.content)
                                    .lineLimit(1)
                                    .font(.headline)
                                Text(entry.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            
                            .padding()
                            .cornerRadius(10)
                        }
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteEntries)
                }
                
                .listStyle(PlainListStyle())
                .background(Color("PaperColor"))
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Diary")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: NewDiaryEntryView(viewModel: viewModel)){
                    Image(systemName:"plus")
                }
                )
                
            }
            .background(Color("PaperColor"))
        }
    
    private func deleteEntries(at offsets:IndexSet){
        viewModel.deleteEntry(at: offsets)
        }
    
    }
    



    struct DiaryListView_Previews: PreviewProvider {
        static var previews: some View {
            DiaryListView()
        }
    }

