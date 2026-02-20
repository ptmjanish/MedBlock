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
    
    static func pagePadding(_ sizeCategory: ContentSizeCategory) -> CGFloat {
        sizeCategory.isAccessibilityCategory ? 20 : 16
    }
    
    static func blockSpacing(_ sizeCategory: ContentSizeCategory) -> CGFloat {
        sizeCategory.isAccessibilityCategory ? 18 : 16
    }
    
    static func cardRadius(_ sizeCategory: ContentSizeCategory) -> CGFloat {
        sizeCategory.isAccessibilityCategory ? 20 : 18
    }
    
    static func innerRadius(_ sizeCategory: ContentSizeCategory) -> CGFloat {
        sizeCategory.isAccessibilityCategory ? 16 : 14
    }
    
    // MARK: - Typography
    static func headingFont(level: Int, isCompact: Bool) -> Font {
        switch level {
        case 1:
            return (isCompact ? Font.title.weight(.bold) : Font.largeTitle.weight(.bold))
        case 2:
            return .title2.weight(.semibold)
        case 3:
            return .headline.weight(.semibold)
        default:
            return .headline.weight(.semibold)
        }
    }
    
    static let body: Font = .body
    static let caption: Font = .footnote
    
    // MARK: - Surfaces
    static func surface(_ level: SurfaceLevel) -> Color {
        switch level {
        case .base: return Color(.systemBackground)
        case .card: return Color(.secondarySystemBackground)
        case .raised: return Color(.tertiarySystemBackground)
        case .accentSoft: return Color.accentColor.opacity(0.10)
        case .secondary: return Color.secondary
        }
    }
    
    enum SurfaceLevel { case base, card, raised, accentSoft, secondary }
    
    // MARK: - Lines
    static var separator: Color { Color(.separator) }
    static var outline: Color { Color(.separator).opacity(0.6) }
    static func cardStroke() -> Color { Color(.separator).opacity(0.35) }
    
    // MARK: - Callouts
    static func calloutTint(_ style: CalloutBlock.Style) -> Color {
        switch style {
        case .warning: return .orange
        case .tip: return .green
        case .info: return .blue
        }
    }
    
    static func calloutBackground(_ style: CalloutBlock.Style) -> Color {
        switch style {
        case .warning: return calloutTint(style).opacity(0.14)
        case .tip: return calloutTint(style).opacity(0.12)
        case .info: return calloutTint(style).opacity(0.12)
        }
    }
    
    static func calloutBorder(_ style: CalloutBlock.Style) -> Color {
        calloutTint(style).opacity(0.35)
    }
    
    // MARK: - Highlight
    static func highlightOpacity(reduceTransparency: Bool, increasedContrast: Bool) -> Double {
        if increasedContrast { return 0.22 }
        if reduceTransparency { return 0.18 }
        return 0.10
    }
}
