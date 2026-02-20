//
//  CalloutBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct CalloutBlockView: View {
    let block: CalloutBlock

    var body: some View {
        let tint = DS.calloutTint(block.style)

        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(tint)

            VStack(alignment: .leading, spacing: 6) {
                Text(block.title)
                    .font(.headline.weight(.semibold))
                Text(block.text)
                    .font(DS.body)
                    .lineSpacing(4)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius)
                .fill(DS.surface(.card))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.cardRadius)
                        .fill(tint.opacity(0.10))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DS.cardRadius)
                        .stroke(tint.opacity(0.25), lineWidth: 1)
                )
        )
        .accessibilityElement(children: .combine)
    }

    private var iconName: String {
        switch block.style {
        case .warning: return "exclamationmark.triangle.fill"
        case .tip: return "lightbulb.fill"
        case .info: return "info.circle.fill"
        }
    }
}
