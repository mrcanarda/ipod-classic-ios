import SwiftUI

struct iPodBodyView: View {
    @StateObject var vm = iPodViewModel()
    @ObservedObject var music = MusicManager.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red: 0.96, green: 0.96, blue: 0.96))
                        .shadow(color: .black.opacity(0.6), radius: 24, x: 0, y: 12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(red: 0.78, green: 0.78, blue: 0.78), lineWidth: 1)
                        )
                    
                    VStack(spacing: 16) {
                        // Screen
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.black)
                                .padding(2)
                            
                            ScreenView()
                                .environmentObject(vm)
                                .environmentObject(music)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        .frame(width: 310, height: 230)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(Color.black, lineWidth: 3)
                        )
                        
                        // Mini now playing bar
                        if music.isPlaying || music.currentSong != nil {
                            HStack(spacing: 6) {
                                Image(systemName: music.isPlaying ? "play.fill" : "pause.fill")
                                    .font(.system(size: 9))
                                    .foregroundColor(.gray)
                                
                                Text(music.currentSong?.title ?? "")
                                    .font(.system(size: 10, weight: .medium))
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Text("—")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray.opacity(0.6))
                                
                                Text(music.currentSong?.artist ?? "")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray.opacity(0.6))
                                    .lineLimit(1)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 5)
                            .background(Color.black.opacity(0.06))
                            .clipShape(Capsule())
                            .onTapGesture {
                                vm.slideDirection = 1
                                if vm.currentScreen != .nowPlaying {
                                    vm.screenStack.append(.nowPlaying)
                                }
                            }
                        }
                        
                        // Apple logo
                        Image(systemName: "apple.logo")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 0.72, green: 0.72, blue: 0.72))
                            .padding(.bottom, 2)
                        
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
