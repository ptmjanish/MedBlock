//
//  HighlightPicker.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct HighlightPicker: View {
    let current: HighlightStore.Highlight
    let onSelect: (HighlightStore.Highlight) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Highlight")
                .font(.headline)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 5), spacing: 12) {
                ForEach(HighlightStore.Highlight.allCases) { h in
                    Button {
                        onSelect(h)
                    } label: {
                        Circle()
                            .fill(color(for: h).opacity(h == .none ? 0.12 : 0.6))
                            .overlay(
                                Circle().stroke(current == h ? Color.primary : .clear, lineWidth: 2)
                            )
                            .frame(height: 44)
                            .overlay(
                                Text(label(for: h))
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 64),
                                alignment: .top
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(label(for: h))
                }
            }

            Spacer(minLength: 0)
        }
        .padding(16)
    }

    private func color(for h: HighlightStore.Highlight) -> Color {
        switch h {
        case .none: return .gray
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .pink: return .pink
        }
    }

    private func label(for h: HighlightStore.Highlight) -> String {
        h.rawValue.capitalized
    }
}