//
//  HapticManager.swift
//  iPod
//
//  Created by Can Arda on 08.03.26.
//

import UIKit

struct HapticManager {
    static func tick () {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static func select () {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    static func back() {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred()
    }
}
