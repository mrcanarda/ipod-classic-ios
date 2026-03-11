//
//  NowPlayingScreenView.swift
//  iPod
//
//  Created by Can Arda on 08.03.26.
//

import SwiftUI

struct NowPlayingScreenView: View {
    var body: some View {
        VStack(spacing: 6) {
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "music.note")
                        .font(.system(size: 30))
                        .foregroundColor(.white.opacity(0.4))
                )
                .padding(.top, 8)
            
            Text("No Track Playing")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color("iPodScreenText"))
            
            Text("Unknown Artist")
                .font(.system(size: 10))
                .foregroundColor(Color("iPodScreenText").opacity(0.6))
            
            VStack(spacing: 2) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 3)
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color("iPodScreenText"))
                            .frame(width: geo.size.width * 0.35, height: 3)
                    }
                }
                .frame(height: 3)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("1:23")
                        .font(.system(size: 9))
                        .foregroundColor(Color("iPodScreenText").opacity(0.6))
                    Spacer()
                    Text("-2:11")
                        .font(.system(size: 9))
                        .foregroundColor(Color("iPodScreenText").opacity(0.6))
                }
                .padding(.horizontal, 10)
            }
            
            Spacer()
        }
        .background(Color("iPodScreen"))
    }
}
