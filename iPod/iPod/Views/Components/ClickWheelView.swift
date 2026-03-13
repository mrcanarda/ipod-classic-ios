//
//  ClickWheelView.swift
//  iPod
//
//  Created by Can Arda on 08.03.26.
//

import SwiftUI

struct ClickWheelView: View {
    @EnvironmentObject var vm: iPodViewModel
    
    @State private var isDragging = false
    
    let wheelSize: CGFloat = 300
    let centerSize: CGFloat = 95
    
    var body: some View {
        ZStack {
            // Outer wheel
            Circle()
                .fill(
                    RadialGradient(
                        colors: [Color("iPodWheelLight"), Color("iPodWheelGray"), Color("iPodWheelDark")],
                        center: .center,
                        startRadius: 40,
                        endRadius: 140
                    )
                )
                .frame(width: wheelSize, height: wheelSize)
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                )
                .gesture(
                    DragGesture(minimumDistance: 5)
                        .onChanged { value in
                            let center = CGPoint(x: wheelSize / 2, y: wheelSize / 2)
                            let angle = angleTo(point: value.location, from: center)
                            if !isDragging {
                                isDragging = true
                                vm.resetWheel(at: angle)
                            } else {
                                vm.updateWheelAngle(angle)
                            }
                        }
                        .onEnded { _ in
                            isDragging = false
                        }
                )
            
            // MENU (üst)
            Button {
                HapticManager.back()
                vm.goBack()
            } label: {
                Text("MENU")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("iPodWheelText"))
                    .frame(width: 70, height: 40)
            }
            .offset(y: -(wheelSize / 2 - 28))
            
            // Forward (sağ)
            Button {
                HapticManager.select()
                vm.skipNext()
            } label: {
                Image(systemName: "forward.end.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("iPodWheelText"))
                    .frame(width: 40, height: 40)
            }
            .offset(x: wheelSize / 2 - 32)
            
            // Backward (sol)
            Button {
                HapticManager.select()
                vm.skipPrevious()
            } label: {
                Image(systemName: "backward.end.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("iPodWheelText"))
                    .frame(width: 40, height: 40)
            }
            .offset(x: -(wheelSize / 2 - 32))
            
            // Play/Pause (alt)
            Button {
                HapticManager.select()
                vm.togglePlayPause()
            } label: {
                Image(systemName: "playpause.fill")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("iPodWheelText"))
                    .frame(width: 40, height: 40)
            }
            .offset(y: wheelSize / 2 - 28)
            
            // Center button
            Button {
                HapticManager.select()
                vm.selectCurrent()
            } label: {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color("iPodWheelLight"), Color("iPodWheelGray")],
                            center: .topLeading,
                            startRadius: 5,
                            endRadius: 60
                        )
                    )
                    .frame(width: centerSize, height: centerSize)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            }
        }
    }
    
    private func angleTo(point: CGPoint, from center: CGPoint) -> Double {
        let deltaX = point.x - center.x
        let deltaY = point.y - center.y
        let radians = atan2(deltaY, deltaX)
        var degrees = radians * 180 / .pi
        if degrees < 0 { degrees += 360 }
        return degrees
    }
}
