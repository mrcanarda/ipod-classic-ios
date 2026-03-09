import SwiftUI

struct MenuRowView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(isSelected ? .white : .black)
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
        .background(isSelected ? Color("iPodBlue") : Color(red: 0.82, green: 0.88, blue: 0.96))
    }
}
