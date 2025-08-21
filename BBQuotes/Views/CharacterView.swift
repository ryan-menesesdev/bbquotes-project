import SwiftUI

struct CharacterView: View {
    let character: Char
    let show: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top) {
                    Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                        .resizable()
                        .scaledToFit()
                    
                    ScrollView {
                        TabView {
                            ForEach(character.images, id: \.self) { characterImageUrl in
                                AsyncImage(url: characterImageUrl) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.8)
                        .clipShape(.rect(cornerRadius: 50))
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading) {
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrated by: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider()
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            
                            Text("Born: \(character.birthday)")
                            
                            Divider()
                            
                            Text("Occupations:")
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("• \(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider()
                            
                            if character.aliases.count > 0 {
                                Text("Nicknames:")
                                ForEach(character.aliases, id: \.self) { alliase in
                                    Text("• \(alliase)")
                                        .font(.subheadline)
                                }
                            } else {
                                Text("None")
                            }
                            
                            Divider()
                            
                            DisclosureGroup("Status (spoiler alert!)") {
                                VStack(alignment: .leading) {
                                    Text(character.status)
                                        .font(.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                
                                if let death = character.death {
                                    AsyncImage(url: death.image) { img in
                                        img
                                            .resizable()
                                            .scaledToFit()
                                            .onAppear() {
                                                withAnimation {
                                                    proxy.scrollTo(1, anchor: .bottom)
                                                }
                                            }
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("How: \(death.details)")
                                        Text("\nLast words: \(death.lastWords)")
                                        Text("\nEpisode: \(death.episode)")
                                        Text("\nCaused by:")
                                        ForEach(death.responsible, id: \.self) { responsible in
                                            Text("• \(responsible)")
                                        }
                                    }
                                }
                                
                            }
                            .tint(.primary)
                            
                        }
                        .padding(.bottom, 32)
                        .frame(width: geo.size.width/1.2, alignment: .leading)
                        .id(1)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .ignoresSafeArea()
        .padding(.bottom, 8)
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: ShowNameConstants.bbName)
}
