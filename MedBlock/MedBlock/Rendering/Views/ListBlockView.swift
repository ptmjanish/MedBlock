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
        VStack(alignment: .leading, spacing: 10) {
            ForEach(Array(block.items.enumerated()), id: \.offset) { idx, item in
                HStack(alignment: .top, spacing: 10) {
                    Text(prefix(for: idx))
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)
                        .frame(width: 26, alignment: .leading)

                    Text(item)
                        .font(.body)
                        .lineSpacing(3)
                }
            }
        }
        .padding(12)
        .background(Color.primary.opacity(0.04))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private func prefix(for idx: Int) -> String {
        block.ordered ? "\(idx + 1)." : "•"
    }
}