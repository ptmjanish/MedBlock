//
//  ComparisonBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ComparisonBlockView: View {
    let block: ComparisonBlock

    var body: some View {
        ViewThatFits(in: .horizontal) {
            // Wide: 2 columns side-by-side (or more)
            HStack(alignment: .top, spacing: 12) {
                ForEach(block.columns) { col in
                    ComparisonColumnView(column: col)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }

            // Narrow: stacked
            VStack(alignment: .leading, spacing: 12) {
                ForEach(block.columns) { col in
                    ComparisonColumnView(column: col)
                }
            }
        }
        .padding(12)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct ComparisonColumnView: View {
    let column: ComparisonBlock.Column

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(column.title)
                .font(.headline)
                .padding(.bottom, 2)

            ForEach(column.items) { item in
                HStack(alignment: .firstTextBaseline) {
                    Text(item.label)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Spacer(minLength: 12)
                    Text(item.value)
                        .font(.subheadline)
                        .multilineTextAlignment(.trailing)
                }
                Divider().opacity(0.5)
            }
        }
        .padding(12)
        .background(Color.primary.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}