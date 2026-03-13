import SwiftUI

struct ThemeSettingsView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach(iPodTheme.allCases, id: \.self) { theme in
                    HStack {
                        // Color Overview
                        Circle()
                            .fill(theme.selectedRowColor)
                            .frame(width: 14, height: 14)
                            .padding(.leading, 12)
                        
                        Text(theme.rawValue)
                            .font(.system(size: 14))
                            .foregroundColor(vm.currentTheme == theme ? .white : .black)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        if vm.currentTheme == theme {
                            Image(systemName: "checkmark")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .background(vm.currentTheme == theme ? vm.currentTheme.selectedRowColor : Color.clear)
                    .onTapGesture {
                        vm.currentTheme = theme
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(vm.currentTheme.screenBackground)
    }
}
