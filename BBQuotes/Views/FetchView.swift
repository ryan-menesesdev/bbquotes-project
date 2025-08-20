import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let show: String
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(show.lowercased().replacingOccurrences(of:" ", with: ""))
                    .resizable()
                    .frame(width: geo.size.width * 2.7 , height: geo.size.height * 1.2)
                
                VStack {
                    VStack {
                        Spacer(minLength: 60)
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .sucessQuote:
                            Text("\(vm.quote.quote)")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: vm.character.images[0]) { img in
                                    img
                                        .resizable()
                                        .scaledToFit()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                
                                Text(vm.quote.character)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                            .clipShape(.rect(cornerRadius: 50))
                            .onTapGesture {
                                    showCharacterInfo.toggle()
                            }
                            
                        case .sucessEpisode:
                            EpisodeView(episode: vm.episode)
                                
                            
                        case .failed:
                            Text("Not possible")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            Task {
                                await vm.getQuoteData(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                        }
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                        .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                        .clipShape(.rect(cornerRadius: 10))
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await vm.getEpisodeData(for: show)
                            }
                        } label: {
                            Text("Get Random Episode")
                        }
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Button"))
                        .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer(minLength: 95)
                }
                .frame(width: geo.size.width, height: geo.size.height)
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
        .toolbarBackgroundVisibility(.visible, for: .tabBar)
        .sheet(isPresented: $showCharacterInfo) {
            CharacterView(character: vm.character, show: show)
        }
    }
}

#Preview {
    FetchView(show: ShowNameConstants.bbName)
        .preferredColorScheme(.dark)
}
