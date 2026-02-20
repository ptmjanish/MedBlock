//
//  MnemonicBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct MnemonicBlockView: View {
    let block: MnemonicBlock

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(block.title)
                .font(.headline)

            ForEach(block.letters) { l in
                HStack(alignment: .top, spacing: 10) {
                    Text(l.letter)
                        .font(.headline)
                        .frame(width: 28, height: 28)
                        .background(Color.accentColor.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(l.expansion)
                        .font(.body)
                        .lineSpacing(3)
                }
            }
        }
        .padding(12)
        .background(Color.accentColor.opacity(0.06))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}