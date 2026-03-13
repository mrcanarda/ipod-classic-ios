import SwiftUI

struct ScreenView: View {
    @EnvironmentObject var vm: iPodViewModel
    @EnvironmentObject var music: MusicManager
    
    var body: some View {
        VStack(spacing: 0) {
            // Title bar
            ZStack {
                vm.currentTheme.titleBarColor
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
            
            // Content
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
                .environmentObject(music)
        case .songList:
            SongListView()
        case .themeSettings:
            ThemeSettingsView()
        case .aboutSettings:
            AboutView()
        default:
            EmptyListView()
        }
    }
}
