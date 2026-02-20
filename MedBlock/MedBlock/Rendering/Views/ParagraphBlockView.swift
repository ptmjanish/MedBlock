//
//  ParagraphBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI
import UIKit

struct ParagraphBlockView: View {
    let blockId: String
    let block: ParagraphBlock

    @EnvironmentObject private var highlightStore: HighlightStore
    @Environment(\.sizeCategory) private var sizeCategory

   // @Environment(\.accessibilityIncreaseContrast) private var increaseContrast
    @Environment(\.accessibilityReduceTransparency) private var reduceTransparency

    @State private var showPicker = false

    var body: some View {
        let radius = DS.cardRadius(sizeCategory)
        let highlight = highlightStore.highlight(for: blockId)
        let plainText = block.content.map(\.text).joined()

        Text(attributedContent())
            .font(DS.body)
            .foregroundStyle(.primary)
            .lineSpacing(5)
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: radius)
                    .fill(DS.surface(.card))
                    .overlay(
                        RoundedRectangle(cornerRadius: radius)
                            .stroke(DS.cardStroke(), lineWidth: 1)
                    )
            }
            .contentShape(RoundedRectangle(cornerRadius: radius))
            .onLongPressGesture(minimumDuration: 0.35) {
                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                showPicker = true
            }
            .modifier(AdaptiveHighlightPicker(
                isPresented: $showPicker,
                current: highlight,
                onSelect: { new in
                    highlightStore.setHighlight(new, for: blockId)
                    showPicker = false
                }
            ))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(plainText)
            .accessibilityHint("Long press to highlight")
            .accessibilityValue(highlight == .none ? "Not highlighted" : "Highlighted \(highlight.rawValue)")
    }

    private func attributedContent() -> AttributedString {
        var result = AttributedString()

        let h = highlightStore.highlight(for: blockId)
        let highlightUIColor = uiColor(for: h)?.withAlphaComponent(highlightAlpha())

        for span in block.content {
            var part = AttributedString(span.text)
            let base = UIFont.preferredFont(forTextStyle: .body)
            part.font = span.bold ? base.withTraits(.traitBold) : base

            if let bg = highlightUIColor, h != .none {
                part.backgroundColor = bg
            }

            result.append(part)
        }

        return result
    }

    private func highlightAlpha() -> CGFloat {
        if reduceTransparency { return 0.30 }
        return 0.28
    }

    private func uiColor(for h: HighlightStore.Highlight) -> UIColor? {
        switch h {
        case .none: return nil
        case .yellow: return .systemYellow
        case .green: return .systemGreen
        case .blue: return .systemBlue
        case .pink: return .systemPink
        }
    }
}
