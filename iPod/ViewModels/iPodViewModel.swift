import SwiftUI
import Combine

class iPodViewModel: ObservableObject {
    
    // MARK: - Navigation Stack
    @Published var screenStack: [iPodScreen] = [.mainMenu]
    
    var currentScreen: iPodScreen {
        screenStack.last ?? .mainMenu
    }
    
    // MARK: - Menu State
    @Published var selectedIndex: Int = 0
    @Published var slideDirection: Int = 1

    @Published var currentTheme: iPodTheme = .classic

    // MARK: - Music Manager
    @Published var music = MusicManager.shared
    
    // MARK: - Menus
    var mainMenuItems: [MenuItem] {
        [
            MenuItem(title: "Music", screen: .musicMenu),
            MenuItem(title: "Now Playing", screen: .nowPlaying),
            MenuItem(title: "Photos", screen: .photosView),

            MenuItem(title: "Settings", screen: .settings),
        ]
    }
    
    var musicMenuItems: [MenuItem] {
        [
            MenuItem(title: "Playlists", screen: .playlistList),
            MenuItem(title: "Artists", screen: .artistList),
            MenuItem(title: "Albums", screen: .albumList),
            MenuItem(title: "Songs", screen: .songList),
            MenuItem(title: "Now Playing", screen: .nowPlaying),
        ]
    }
    
    var settingsMenuItems: [MenuItem] {
        [
            MenuItem(title: "Theme", screen: .themeSettings),
            MenuItem(title: "About", screen: .aboutSettings),
        ]
    }
    
    var currentMenuItems: [MenuItem] {
        switch currentScreen {
        case .mainMenu: return mainMenuItems
        case .musicMenu: return musicMenuItems
        case .settings: return settingsMenuItems
        default: return []
        }
    }
    
    // MARK: - Wheel State
    private var lastAngle: Double = 0
    private var accumulatedDelta: Double = 0
    private let tickThreshold: Double = 30.0
    
    // MARK: - Navigation
    func selectCurrent() {
        switch currentScreen {
        case .mainMenu, .musicMenu, .settings, .themeSettings:
            let items = currentMenuItems
            guard selectedIndex < items.count else { return }
            let item = items[selectedIndex]
            if let screen = item.screen {
                slideDirection = 1
                screenStack.append(screen)
                selectedIndex = 0
            }
            item.action?()
        case .artistList:
            slideDirection = 1
            screenStack.append(.songList)
            selectedIndex = 0
        case .albumList:
            slideDirection = 1
            screenStack.append(.songList)
            selectedIndex = 0
        case .playlistList:
            slideDirection = 1
            screenStack.append(.songList)
            selectedIndex = 0
        default:
            break
        }
    }
    
    func goBack() {
        guard screenStack.count > 1 else { return }
        slideDirection = -1
        screenStack.removeLast()
        selectedIndex = 0
    }
    
    func menuUp() {
        guard !currentMenuItems.isEmpty else { return }
        selectedIndex = max(0, selectedIndex - 1)
    }
    
    func menuDown() {
        guard !currentMenuItems.isEmpty else { return }
        selectedIndex = min(currentMenuItems.count - 1, selectedIndex + 1)
    }
    
    // MARK: - Wheel
    func updateWheelAngle(_ newAngle: Double) {
        let delta = angleDifference(from: lastAngle, to: newAngle)
        lastAngle = newAngle
        accumulatedDelta += delta
        
        if accumulatedDelta > tickThreshold {
            accumulatedDelta = 0
            menuDown()
            HapticManager.tick()
        } else if accumulatedDelta < -tickThreshold {
            accumulatedDelta = 0
            menuUp()
            HapticManager.tick()
        }
    }
    
    func resetWheel(at angle: Double) {
        lastAngle = angle
        accumulatedDelta = 0
    }
    
    private func angleDifference(from: Double, to: Double) -> Double {
        var diff = to - from
        while diff > 180 { diff -= 360 }
        while diff < -180 { diff += 360 }
        return diff
    }
    
    // MARK: - Screen Title
    var screenTitle: String {
        switch currentScreen {
        case .mainMenu: return "iPod"
        case .musicMenu: return "Music"
        case .settings: return "Settings"
        case .nowPlaying: return "Now Playing"
        case .songList: return "Songs"
        case .artistList: return "Artists"
        case .albumList: return "Albums"
        case .playlistList: return "Playlists"
        case .themeSettings: return "Theme"
        case .aboutSettings: return "About"
        case .photosView: return "Photos"

        }
    }
    // MARK: - Music Actions
    func togglePlayPause() {
        music.togglePlayPause()
    }

    func skipNext() {
        music.skipNext()
    }

    func skipPrevious() {
        music.skipPrevious()
    }
}
