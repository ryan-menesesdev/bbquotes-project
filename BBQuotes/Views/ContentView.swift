import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(ShowNameConstants.bbName, systemImage: "tortoise") {
                FetchView(show: ShowNameConstants.bbName)
            }
            
            Tab(ShowNameConstants.bcsName, systemImage: "briefcase") {
                FetchView(show: ShowNameConstants.bcsName)
            }
            
            Tab(ShowNameConstants.ecName, systemImage: "car") {
                FetchView(show: ShowNameConstants.ecName)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
