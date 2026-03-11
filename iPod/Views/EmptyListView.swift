//
//  EmptyListView.swift
//  iPod
//
//  Created by Can Arda on 08.03.26.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Coming Soon")
                .font(.system(size:12))
                .foregroundColor(Color("iPodScreenText").opacity(0.4))
            Spacer()
        }
        .background(Color("iPodScreen"))
    }
}
