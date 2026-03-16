//
//  PlaylistListView.swift
//  iPod
//
//  Created by Can Arda on 16.03.26.
//

import SwiftUI

struct PlaylistListView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    let playlists: [(name: String, count: String)] = [
        ("Favorites", "12 songs"),
        ("Workout", "8 songs"),
        ("Late Night", "15 songs"),
        ("Road Trip", "20 songs"),
        ("Chill", "10 songs"),
    ]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(playlists.enumerated()), id: \.offset) { index, playlist in
                        HStack {
                            Image(systemName: "music.note.list")
                                .font(.system(size: 12))
                                .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor.opacity(0.5))
                                .padding(.leading, 12)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(playlist.name)
                                    .font(.system(size: 14))
                                    .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor)
                                    .lineLimit(1)
                                Text(playlist.count)
                                    .font(.system(size: 11))
                                    .foregroundColor(index == vm.selectedIndex ? .white.opacity(0.8) : vm.currentTheme.textColor.opacity(0.5))
                                    .lineLimit(1)
                            }
                            .padding(.leading, 6)
                            
                            Spacer()
                            
                            if index == vm.selectedIndex {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white)
                                    .padding(.trailing, 10)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 38)
                        .background(index == vm.selectedIndex ? vm.currentTheme.selectedRowColor : Color.clear)
                        .id(index)
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
        .background(vm.currentTheme.screenBackground)
    }
}
