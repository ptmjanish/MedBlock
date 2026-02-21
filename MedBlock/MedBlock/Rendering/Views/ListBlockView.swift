//
//  ListBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ListBlockView: View {
    let block: ListBlock
    @Environment(\.sizeCategory) private var sizeCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(block.items.enumerated()), id: \.offset) { idx, item in
                HStack(alignment: .top, spacing: 6) {
                    bulletView(for: idx)

                    Text(item)
                        .font(DS.body)
                        .foregroundStyle(.primary)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(accessibilityLabel(for: idx, item: item))
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius(sizeCategory))
                .fill(DS.surface(.card))
        )
    }

    @ViewBuilder
    private func bulletView(for idx: Int) -> some View {
        if block.ordered {
            Text("\(idx + 1).")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)
                .frame(width: 24, alignment: .leading)
                .padding(.top, 2)
                .accessibilityHidden(true)
        } else {
            Circle()
                .fill(Color.secondary)
                .frame(width: 7, height: 7)
                .padding(.top, 9)
                .frame(width: 24, alignment: .leading)
                .accessibilityHidden(true)
        }
    }

    private func accessibilityLabel(for idx: Int, item: String) -> String {
        block.ordered ? "\(idx + 1). \(item)" : item
    }
}
