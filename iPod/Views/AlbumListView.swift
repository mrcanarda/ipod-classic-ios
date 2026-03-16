//
//  AlbumListView.swift
//  iPod
//
//  Created by Can Arda on 16.03.26.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    let albums: [(title: String, artist: String)] = [
        ("ObZen", "Meshuggah"),
        ("The Fragile", "Nine Inch Nails"),
        ("Blackwater Park", "Opeth"),
        ("Plagues", "The Devil Wears Prada"),
        ("Mirror of Souls", "Theocracy"),
        ("Colony", "In Flames"),
        ("Versus the World", "Amon Amarth"),
        ("Ghost Reveries", "Opeth"),
        ("Reroute to Remain", "In Flames"),
        ("Nothing", "Meshuggah"),
    ]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(Array(albums.enumerated()), id: \.offset) { index, album in
                        HStack {
                            Image(systemName: "square.stack")
                                .font(.system(size: 12))
                                .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor.opacity(0.5))
                                .padding(.leading, 12)
                            
                            VStack(alignment: .leading, spacing: 1) {
                                Text(album.title)
                                    .font(.system(size: 14))
                                    .foregroundColor(index == vm.selectedIndex ? .white : vm.currentTheme.textColor)
                                    .lineLimit(1)
                                Text(album.artist)
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
