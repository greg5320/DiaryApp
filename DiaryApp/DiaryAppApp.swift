

import SwiftUI

@main
struct DiaryAppApp: App {
    var body: some Scene {
        WindowGroup {
            DiaryListView()
                .preferredColorScheme(.light)
        }
    }
    
}
