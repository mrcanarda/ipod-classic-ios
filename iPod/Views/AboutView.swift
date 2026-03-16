//
//  AboutView.swift
//  iPod
//
//  Created by Can Arda on 12.03.26.
//

import SwiftUI

struct AboutView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                AboutRowView(label: "Version", value: "1.0.0")
                AboutRowView(label: "Developer", value: "Can Arda")
                AboutRowView(label: "GitHub", value: "mrcanarda")
                AboutRowView(label: "Songs", value: "10")
                AboutRowView(label: "Model", value: "iPod Classic 5G")
                AboutRowView(label: "Software", value: "SwiftUI")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(vm.currentTheme.screenBackground)
    }
}

struct AboutRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.black)
                .padding(.leading, 12)
            Spacer()
            Text(value)
                .font(.system(size: 13))
                .foregroundColor(.black.opacity(0.5))
                .padding(.trailing, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 30)
        .background(Color.clear)
        .overlay(
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 0.5),
            alignment: .bottom
        )
    }
}
