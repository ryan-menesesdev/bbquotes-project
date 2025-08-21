import SwiftUI

struct RandomCharacterView: View {
    var character: Char
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(character.name)")
                .font(.largeTitle)
            
            AsyncImage(url: character.images.randomElement()) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }

            Text(character.portrayedBy)
                .font(.title2)
            
            Text("Birth date: \(character.birthday)")
                .font(.subheadline)
                .minimumScaleFactor(0.5)
                .padding(.bottom)
        }
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    RandomCharacterView(character: ViewModel().character)
}
