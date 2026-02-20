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
                HStack(alignment: .firstTextBaseline, spacing: 12) {
                    Text(prefix(for: idx))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 28, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false) // ✅ keep prefix tight

                    Text(item)
                        .font(DS.body)
                        .foregroundStyle(.primary)
                        .lineSpacing(4)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil) // ✅ allow wrapping
                        .fixedSize(horizontal: false, vertical: true) // ✅ expand vertically
                        .frame(maxWidth: .infinity, alignment: .leading) // ✅ take available width
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius)
                .fill(DS.surface(.card))
        )
    }
    
    @ViewBuilder
    private func bulletView(for idx: Int) -> some View {
        if block.ordered {
            Text("\(idx + 1)")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(width: 24, height: 24)
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(DS.surface(.secondary))
                )
        } else {
            Circle()
                .fill(.primary)
                .frame(width: 10, height: 10)
                .padding(.top, 8)
                .frame(width: 24, alignment: .leading)
        }
    }

    private func prefix(for idx: Int) -> String {
        block.ordered ? "\(idx + 1)." : "•"
    }
}
