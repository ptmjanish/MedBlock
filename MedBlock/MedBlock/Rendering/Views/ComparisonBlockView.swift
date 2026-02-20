//
//  ComparisonBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ComparisonBlockView: View {
    let block: ComparisonBlock
    @Environment(\.sizeCategory) private var sizeCategory

    var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(block.columns) { col in
                    ComparisonColumnView(column: col)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                ForEach(block.columns) { col in
                    ComparisonColumnView(column: col)
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius(sizeCategory))
                .fill(DS.surface(.card))
        )
        .accessibilityElement(children: .contain)
    }
}

private struct ComparisonColumnView: View {
    let column: ComparisonBlock.Column
    @Environment(\.sizeCategory) private var sizeCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(column.title)
                .font(.headline.weight(.semibold))
                .padding(.bottom, 2)

            ForEach(column.items) { item in
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Text(item.label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Spacer(minLength: 8)

                    Text(item.value)
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 6)
                .overlay(alignment: .bottom) {
                    Divider().opacity(0.35)
                }
                .accessibilityLabel("\(item.label), \(item.value)")
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.innerRadius(sizeCategory))
                .fill(DS.surface(.raised))
        )
    }
}
