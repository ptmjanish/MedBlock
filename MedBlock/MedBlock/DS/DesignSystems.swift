//
//  DS.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum DS {
    // MARK: - Layout
    static let pageMaxWidth: CGFloat = 760
    static let pagePadding: CGFloat = 16
    static let blockSpacing: CGFloat = 16
    static let cardRadius: CGFloat = 18
    static let innerRadius: CGFloat = 14

    // MARK: - Typography
    static func headingFont(level: Int) -> Font {
        switch level {
        case 1: return .system(.largeTitle, design: .default).weight(.bold)
        case 2: return .system(.title2, design: .default).weight(.semibold)
        case 3: return .system(.headline, design: .default).weight(.semibold)
        default: return .system(.headline, design: .default).weight(.semibold)
        }
    }

    static let body = Font.body
    static let caption = Font.footnote

    // MARK: - Surfaces (Dark-mode friendly)
    // Use subtle contrast. Avoid “muddy” stacking of random opacities.
    static func surface(_ level: SurfaceLevel) -> Color {
        switch level {
        case .base:
            return Color(.systemBackground)
        case .card:
            return Color(.secondarySystemBackground)
        case .raised:
            return Color(.tertiarySystemBackground)
        case .accentSoft:
            return Color.accentColor.opacity(0.10)
        }
    }

    enum SurfaceLevel { case base, card, raised, accentSoft }

    // MARK: - Callout styling
    static func calloutTint(_ style: CalloutBlock.Style) -> Color {
        switch style {
        case .warning: return .orange
        case .tip: return .green
        case .info: return .blue
        }
    }

    // MARK: - Highlight styling (subtle!)
    static func highlightOpacity() -> Double { 0.10 } // was 0.25, too loud
}