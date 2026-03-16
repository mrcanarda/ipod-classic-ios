import SwiftUI

struct MenuRowView: View {
    let title: String
    let isSelected: Bool
    
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(isSelected ? .white : vm.currentTheme.textColor)
                .padding(.leading, 12)
            Spacer()
            if isSelected {
                Image(systemName: "chevron.right")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 32)
        .background(isSelected ? vm.currentTheme.selectedRowColor : Color.clear)
    }
}
