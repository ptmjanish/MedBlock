//
//  HeadingBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct HeadingBlockView: View {
    let block: HeadingBlock

    var body: some View {
        Text(block.text)
            .font(fontForLevel(block.level))
            .fontWeight(block.level == 1 ? .bold : .semibold)
            .padding(.top, block.level == 1 ? 6 : 2)
            .accessibilityAddTraits(.isHeader)
    }

    private func fontForLevel(_ level: Int) -> Font {
        switch level {
        case 1: return .title
        case 2: return .title2
        case 3: return .headline
        default: return .headline
        }
    }
}