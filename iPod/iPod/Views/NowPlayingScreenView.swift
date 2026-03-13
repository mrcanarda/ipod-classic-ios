import SwiftUI

struct NowPlayingScreenView: View {
    @EnvironmentObject var vm: iPodViewModel
    @EnvironmentObject var music: MusicManager
    
    var progress: Double {
        music.currentTime / music.duration
    }
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.25))
                    .frame(width: 85, height: 85)
                
                Image(systemName: "music.note")
                    .font(.system(size: 28))
                    .foregroundColor(.black.opacity(0.25))
            }
            .padding(.top, 6)
            
            Text(music.currentSong?.title ?? "No Track Playing")
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.black)
                .lineLimit(1)
                .padding(.horizontal, 8)
            
            Text(music.currentSong?.artist ?? "Unknown Artist")
                .font(.system(size: 11))
                .foregroundColor(.black.opacity(0.5))
                .lineLimit(1)
                .padding(.horizontal, 8)
            
            Image(systemName: music.isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: 12))
                .foregroundColor(.black.opacity(0.5))
                .padding(.top, 2)
            
            Spacer()
            
            VStack(spacing: 3) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.black.opacity(0.15))
                            .frame(height: 3)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.black.opacity(0.5))
                            .frame(width: geo.size.width * progress, height: 3)
                        
                        Circle()
                            .fill(Color.black.opacity(0.7))
                            .frame(width: 8, height: 8)
                            .offset(x: max(0, geo.size.width * progress - 4), y: -2.5)
                    }
                }
                .frame(height: 8)
                .padding(.horizontal, 12)
                
                HStack {
                    Text(timeString(music.currentTime))
                        .font(.system(size: 9))
                        .foregroundColor(.black.opacity(0.4))
                    Spacer()
                    Text("-\(timeString(music.duration - music.currentTime))")
                        .font(.system(size: 9))
                        .foregroundColor(.black.opacity(0.4))
                }
                .padding(.horizontal, 12)
            }
            .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.82, green: 0.88, blue: 0.96))
    }
    
    func timeString(_ seconds: Double) -> String {
        let s = max(0, Int(seconds))
        return String(format: "%d:%02d", s / 60, s % 60)
    }
}
