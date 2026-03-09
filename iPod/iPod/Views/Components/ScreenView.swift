import SwiftUI

struct ScreenView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Title bar
            ZStack {
                LinearGradient(
                    colors: [Color("iPodBlue"), Color("iPodBlueDark")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                HStack {
                    Spacer()
                    Text(vm.screenTitle)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "battery.100")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                }
            }
            .frame(height: 24)
            
            // Menu
            screenContent
                .transition(
                    .asymmetric(
                        insertion: .move(edge: vm.slideDirection == 1 ? .trailing : .leading),
                        removal: .move(edge: vm.slideDirection == 1 ? .leading : .trailing)
                    )
                )
                .id(vm.currentScreen)
                .animation(.easeInOut(duration: 0.2), value: vm.currentScreen)
        }
    }
    
    @ViewBuilder
    var screenContent: some View {
        switch vm.currentScreen {
        case .mainMenu, .musicMenu, .settings:
            MenuListView()
        case .nowPlaying:
            NowPlayingScreenView()
        default:
            EmptyListView()
        }
    }
}
