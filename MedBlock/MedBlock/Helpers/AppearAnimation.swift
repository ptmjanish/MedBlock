//
//  AppearAnimation.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct AppearAnimation: ViewModifier {
    let index: Int
    let enabled: Bool

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var appeared = false

    func body(content: Content) -> some View {
        let shouldAnimate = enabled && !reduceMotion

        content
            .opacity(appeared || !shouldAnimate ? 1 : 0)
            .offset(y: appeared || !shouldAnimate ? 0 : 10)
            .onAppear {
                guard shouldAnimate else { return }
                let delay = min(Double(index) * 0.03, 0.35) // capped stagger
                withAnimation(.easeOut(duration: 0.35).delay(delay)) {
                    appeared = true
                }
            }
    }
}

extension View {
    func appearAnimated(index: Int, enabled: Bool = true) -> some View {
        modifier(AppearAnimation(index: index, enabled: enabled))
    }
}