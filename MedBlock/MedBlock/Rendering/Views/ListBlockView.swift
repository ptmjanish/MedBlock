//
//  ListBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ListBlockView: View {
    let block: ListBlock

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(Array(block.items.enumerated()), id: \.offset) { idx, item in
                HStack(alignment: .top, spacing: 12) {
                    Text(prefix(for: idx))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 30, alignment: .leading)

                    Text(item)
                        .font(DS.body)
                        .lineSpacing(4)
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius)
                .fill(DS.surface(.card))
        )
    }

    private func prefix(for idx: Int) -> String {
        block.ordered ? "\(idx + 1)." : "•"
    }
}
