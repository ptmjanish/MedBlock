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
    @State private var showPicker = false

    var body: some View {
        Text(attributedContent())
            .font(DS.body) // acts as a fallback; attributed runs set their own fonts too
            .foregroundStyle(.primary)
            .lineSpacing(5)
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: DS.cardRadius)
                    .fill(DS.surface(.card))
            }
            .contentShape(RoundedRectangle(cornerRadius: DS.cardRadius))
            .onLongPressGesture { showPicker = true }
            .modifier(AdaptiveHighlightPicker(
                isPresented: $showPicker,
                current: highlightStore.highlight(for: blockId),
                onSelect: { new in
                    highlightStore.setHighlight(new, for: blockId)
                    showPicker = false
                }
            ))
            .accessibilityLabel(block.content.map(\.text).joined())
    }

    private func attributedContent() -> AttributedString {
        var result = AttributedString()

        let h = highlightStore.highlight(for: blockId)
        let highlightUIColor = uiColor(for: h)?.withAlphaComponent(0.28) // marker feel

        for span in block.content {
            var part = AttributedString(span.text)

            // Use Dynamic Type friendly UIFonts
            let base = UIFont.preferredFont(forTextStyle: .body)
            part.font = span.bold ? base.withTraits(.traitBold) : base

            // ✅ Apply highlight behind the text only
            if let bg = highlightUIColor, h != .none {
                part.backgroundColor = bg
            }

            result.append(part)
        }

        return result
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
