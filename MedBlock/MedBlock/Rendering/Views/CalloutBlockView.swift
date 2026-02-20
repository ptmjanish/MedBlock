//
//  CalloutBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct CalloutBlockView: View {
    let block: CalloutBlock

    @Environment(\.sizeCategory) private var sizeCategory
   // @Environment(\.accessibilityIncreaseContrast) private var increaseContrast

    var body: some View {
        let tint = DS.calloutTint(block.style)
        let radius = DS.cardRadius(sizeCategory)

        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(tint)
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 6) {
                Text(block.title)
                    .font(.headline.weight(.semibold))
                    .accessibilityAddTraits(.isHeader)

                Text(block.text)
                    .font(DS.body)
                    .lineSpacing(4)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: radius)
                .fill(DS.surface(.card))
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .fill(tint.opacity(0.10))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: radius)
                        .stroke(tint.opacity(0.25), lineWidth: 1)
                )
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(styleLabel). \(block.title). \(block.text)")
    }

    private var styleLabel: String {
        switch block.style {
        case .warning: return "Warning"
        case .tip: return "Tip"
        case .info: return "Info"
        }
    }

    private var iconName: String {
        switch block.style {
        case .warning: return "exclamationmark.triangle.fill"
        case .tip: return "lightbulb.fill"
        case .info: return "info.circle.fill"
        }
    }
}
