import SwiftUI

enum iPodScreen {
    case mainMenu
    case musicMenu
    case settings
    case nowPlaying
    case songList
    case artistList
    case albumList
    case playlistList
    case themeSettings
    case aboutSettings
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

enum iPodTheme: String, CaseIterable {
    case classic = "Classic"
    case midnight = "Midnight"
    case rose = "Rose"
    case forest = "Forest"
    case sunset = "Sunset"
    
    var screenBackground: Color {
        switch self {
        case .classic: return Color(red: 0.82, green: 0.88, blue: 0.96)
        case .midnight: return Color(red: 0.10, green: 0.10, blue: 0.18)
        case .rose: return Color(red: 0.98, green: 0.88, blue: 0.90)
        case .forest: return Color(red: 0.82, green: 0.93, blue: 0.84)
        case .sunset: return Color(red: 0.98, green: 0.92, blue: 0.82)
        }
    }
    
    var titleBarColor: Color {
        switch self {
        case .classic: return Color(red: 0.29, green: 0.56, blue: 0.85)
        case .midnight: return Color(red: 0.20, green: 0.20, blue: 0.40)
        case .rose: return Color(red: 0.85, green: 0.40, blue: 0.55)
        case .forest: return Color(red: 0.25, green: 0.60, blue: 0.35)
        case .sunset: return Color(red: 0.90, green: 0.55, blue: 0.25)
        }
    }
    
    var selectedRowColor: Color {
        switch self {
        case .classic: return Color(red: 0.29, green: 0.56, blue: 0.85)
        case .midnight: return Color(red: 0.30, green: 0.30, blue: 0.60)
        case .rose: return Color(red: 0.85, green: 0.40, blue: 0.55)
        case .forest: return Color(red: 0.25, green: 0.60, blue: 0.35)
        case .sunset: return Color(red: 0.90, green: 0.55, blue: 0.25)
        }
    }
    
    var textColor: Color {
        switch self {
        case .midnight: return Color.white
        default: return Color.black
        }
    }
}
