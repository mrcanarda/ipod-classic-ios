//
//  PhotosView.swift
//  iPod
//
//  Created by Can Arda on 16.03.26.
//
import SwiftUI

struct PhotosView: View {
    @EnvironmentObject var vm: iPodViewModel
    @State private var selectedIndex: Int? = nil
    
    let photos: [(url: String, title: String)] = [
        ("https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400", "Mountains"),
        ("https://images.unsplash.com/photo-1511593358241-7eea1f3c84e5?w=400", "Concert Night"),
        ("https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?w=400", "Cat Photos"),
        ("https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400", "Portrait"),
        ("https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=400", "Japan Trip"),
        ("https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?w=400", "Road Trip"),
        ("https://images.unsplash.com/photo-1415369629372-26f2fe60c467?w=400", "Cat 2"),
        ("https://images.unsplash.com/photo-1542281286-9e0a16bb7366?w=400", "Sunset"),
        ("https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=400", "Travel"),
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            vm.currentTheme.screenBackground
            
            if let index = selectedIndex {
                // Full screen photo
                ZStack(alignment: .bottom) {
                    AsyncImage(url: URL(string: photos[index].url)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                            .overlay(
                                ProgressView()
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipped()
                    
                    // Title + navigation hints
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        Text(photos[index].title)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.black.opacity(0.4))
                    .padding(.bottom, 0)
                }
                .onTapGesture {
                    withAnimation {
                        selectedIndex = nil
                    }
                }
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(Array(photos.enumerated()), id: \.offset) { index, photo in
                            AsyncImage(url: URL(string: photo.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 65)
                                    .clipped()
                            } placeholder: {
                                Color.gray.opacity(0.2)
                                    .frame(width: 90, height: 65)
                                    .overlay(ProgressView().scaleEffect(0.5))
                            }
                            .onTapGesture {
                                withAnimation {
                                    selectedIndex = index
                                }
                            }
                        }
                    }
                    .padding(2)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .photoNext)) { _ in
            guard let current = selectedIndex else { return }
            withAnimation {
                selectedIndex = (current + 1) % photos.count
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .photoPrevious)) { _ in
            guard let current = selectedIndex else { return }
            withAnimation {
                selectedIndex = (current - 1 + photos.count) % photos.count
            }
        }
    }
}

extension Notification.Name {
    static let photoNext = Notification.Name("photoNext")
    static let photoPrevious = Notification.Name("photoPrevious")
}
