//
//  ArtistListView.swift
//  iPod
//
//  Created by Can Arda on 16.03.26.
//

import SwiftUI

struct ArtistListView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    let artists = [
        "Meshuggah",
        "Nine Inch Nails",
        "Opeth",
        "The Devil Wears Prada",
        "Theocracy",
        "In Flames",
        "Amon Amarth",
    ]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(artists.enumerated()), id: \.offset) { index, artist in
                        HStack {
                            Image(systemName: "music.mic")
                                .font(.system(size: 12))
                                .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor.opacity(0.5))
                                .padding(.leading, 12)
                            
                            Text(artist)
                                .font(.system(size: 14))
                                .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor)
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
                        .frame(height: 34)
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
