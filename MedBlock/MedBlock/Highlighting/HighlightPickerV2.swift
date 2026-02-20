//
//  HighlightPickerV2.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct HighlightPickerV2: View {
    let current: HighlightStore.Highlight
    let onSelect: (HighlightStore.Highlight) -> Void

    private let options: [HighlightStore.Highlight] = [.yellow, .green, .blue, .pink]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                header
                preview
                optionsGrid
                clearRow
            }
            .padding(16)
        }
        .scrollIndicators(.hidden)
    }

    private var header: some View {
        HStack {
            Text("Highlight")
                .font(.headline.weight(.semibold))
            Spacer()
        }
        .accessibilityAddTraits(.isHeader)
    }

    private var preview: some View {
        let sample = Text("Example: ")
            .fontWeight(.semibold)
            + Text("This paragraph is highlighted for quick revision and scanning later.")

        return sample
            .font(.subheadline)
            .lineSpacing(4)
            .fixedSize(horizontal: false, vertical: true) // ✅ allow multiline
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(DS.surface(.raised))
            )
    }

    private var optionsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(options) { option in
                HighlightOptionRow(
                    title: option.rawValue.capitalized,
                    color: color(for: option),
                    isSelected: current == option
                ) {
                    onSelect(option)
                }
            }
        }
    }

    private var clearRow: some View {
        Button {
            onSelect(.none)
        } label: {
            HStack(spacing: 10) {
                Image(systemName: "eraser")
                Text("Clear highlight")
                Spacer()
                if current == .none {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
            .font(.subheadline.weight(.semibold))
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(DS.surface(.raised))
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Clear highlight")
    }

    private func color(for h: HighlightStore.Highlight) -> Color {
        switch h {
        case .none: return .clear
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .pink: return .pink
        }
    }
}

private struct HighlightOptionRow: View {
    let title: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Circle()
                    .fill(color.opacity(0.9))
                    .frame(width: 18, height: 18)
                    .overlay(
                        Circle().stroke(Color.primary.opacity(0.12), lineWidth: 1)
                    )

                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.primary.opacity(0.85))
                }
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(DS.surface(.raised))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? Color.primary.opacity(0.18) : .clear, lineWidth: 1)
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}
