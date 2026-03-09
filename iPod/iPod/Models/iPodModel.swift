import Foundation

enum iPodScreen {
    case mainMenu
    case musicMenu
    case settings
    case nowPlaying
    case songList
    case artistList
    case albumList
    case playlistList
}

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let screen: iPodScreen?
    let action: (() -> Void)?
    
    init(title: String, screen: iPodScreen? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.screen = screen
        self.action = action
    }
}
