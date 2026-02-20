//
//  MnemonicBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct MnemonicBlockView: View {
    let block: MnemonicBlock
    @Environment(\.sizeCategory) private var sizeCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(block.title)
                .font(.headline.weight(.semibold))

            ForEach(block.letters) { l in
                HStack(alignment: .top, spacing: 12) {
                    Text(l.letter)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.primary)
                        .frame(width: 26, height: 26)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(DS.surface(.accentSoft))
                        )

                    Text(l.expansion)
                        .font(DS.body)
                        .foregroundStyle(.primary)
                        .lineSpacing(4)
                }
            }
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: DS.cardRadius(sizeCategory))
                .fill(DS.surface(.card))
        )
    }
}
