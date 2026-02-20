//
//  ParagraphBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ParagraphBlockView: View {
    let blockId: String
    let block: ParagraphBlock

    @EnvironmentObject private var highlightStore: HighlightStore
    @State private var showPicker = false

    var body: some View {
        let text = block.content.reduce(Text("")) { partial, span in
            partial + Text(span.text).fontWeight(span.bold ? .semibold : .regular)
        }

        text
            .font(.body)
            .lineSpacing(4)
            .padding(12)
            .background(highlightStore.color(for: blockId).opacity(0.25))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .onLongPressGesture { showPicker = true }
            .sheet(isPresented: $showPicker) {
                HighlightPicker(
                    current: highlightStore.highlight(for: blockId),
                    onSelect: { new in highlightStore.setHighlight(new, for: blockId) }
                )
                .presentationDetents([.height(220)])
            }
            .accessibilityLabel(accessibleString())
    }

    private func accessibleString() -> String {
        block.content.map(\.text).joined()
    }
}