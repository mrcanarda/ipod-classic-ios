import SwiftUI

struct iPodBodyView: View {
    @StateObject var vm = iPodViewModel()
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    // Gövde
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                        .shadow(color: .black.opacity(0.6), radius: 24, x: 0, y: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(red: 0.78, green: 0.78, blue: 0.78), lineWidth: 1)
                        )
                    
                    VStack(spacing: 16) {
                        // Ekran çerçevesi
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.black)
                                .padding(2)
                            
                            ScreenView()
                                .environmentObject(vm)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .frame(width: 310, height: 230)

                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        
                        // Click Wheel
                        ClickWheelView()
                            .environmentObject(vm)
                    }
                    .padding(.vertical, 28)
                }
                .frame(width: 390, height: 720)
            }
        }
    }
}

#Preview {
    iPodBodyView()
}
