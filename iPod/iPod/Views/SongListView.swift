import SwiftUI

struct SongListView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(vm.music.songs.enumerated()), id: \.offset) { index, song in
                        SongRowView(
                            title: song.title,
                            artist: song.artist,
                            isSelected: index == vm.selectedIndex
                        )
                        .id(index)
                        .onTapGesture {
                            vm.selectedIndex = index
                            vm.music.play(song: song)
                            vm.slideDirection = 1
                            vm.screenStack.append(.nowPlaying)
                        }
                    }
                }
            }
            .onChange(of: vm.selectedIndex) { _, newIndex in
                withAnimation {
                    proxy.scrollTo(newIndex, anchor: .center)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.82, green: 0.88, blue: 0.96))
    }
}

struct SongRowView: View {
    let title: String
    let artist: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 1) {
                Text(title)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(isSelected ? .white : .black)
                    .lineLimit(1)
                Text(artist)
                    .font(.system(size: 11))
                    .foregroundColor(isSelected ? .white.opacity(0.8) : .black.opacity(0.5))
                    .lineLimit(1)
            }
            .padding(.leading, 12)
            
            Spacer()
            
            if isSelected {
                Image(systemName: "chevron.right")
                    .font(.system(size: 11))
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 38)
        .background(isSelected ? Color("iPodBlue") : Color.clear)
    }
}
