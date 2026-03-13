import SwiftUI
import Combine

struct MockSong: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let album: String
}

class MusicManager: ObservableObject {
    
    static let shared = MusicManager()
    
    @Published var isPlaying: Bool = false
    @Published var currentSong: MockSong? = nil
    @Published var currentTime: Double = 0
    let duration: Double = 240
    
    private var timer: AnyCancellable?
    
    let songs: [MockSong] = [
        MockSong(title: "Bleed", artist: "Meshuggah", album: "ObZen"),
        MockSong(title: "The Wretched", artist: "Nine Inch Nails", album: "The Fragile"),
        MockSong(title: "Blackwater Park", artist: "Opeth", album: "Blackwater Park"),
        MockSong(title: "Funeral Portrait", artist: "The Devil Wears Prada", album: "Plagues"),
        MockSong(title: "Mirror of Souls", artist: "Theocracy", album: "Mirror of Souls"),
        MockSong(title: "Colony", artist: "In Flames", album: "Colony"),
        MockSong(title: "The Pursuit of Vikings", artist: "Amon Amarth", album: "Versus the World"),
        MockSong(title: "Ghost of Perdition", artist: "Opeth", album: "Ghost Reveries"),
        MockSong(title: "Reroute to Remain", artist: "In Flames", album: "Reroute to Remain"),
        MockSong(title: "Straws Pulled at Random", artist: "Meshuggah", album: "Nothing"),
    ]
    
    private init() {
        currentSong = songs.first
    }
    
    func play(song: MockSong) {
        currentSong = song
        currentTime = 0
        isPlaying = true
        startTimer()
    }
    
    func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    func skipNext() {
        guard let current = currentSong,
              let index = songs.firstIndex(where: { $0.id == current.id }) else { return }
        let nextIndex = (index + 1) % songs.count
        play(song: songs[nextIndex])
    }
    
    func skipPrevious() {
        guard let current = currentSong,
              let index = songs.firstIndex(where: { $0.id == current.id }) else { return }
        let prevIndex = (index - 1 + songs.count) % songs.count
        play(song: songs[prevIndex])
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.currentTime < self.duration {
                    self.currentTime += 1
                } else {
                    self.skipNext()
                }
            }
    }
    
    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
