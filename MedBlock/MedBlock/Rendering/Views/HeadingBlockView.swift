//
//  HeadingBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct HeadingBlockView: View {
    let block: HeadingBlock
    @Environment(\.horizontalSizeClass) private var hSize

    var body: some View {
        Text(block.text)
            .font(fontFor(level: block.level))
            .foregroundStyle(.primary)
            .padding(.top, block.level == 1 ? 10 : 6)
            .padding(.bottom, block.level == 1 ? 4 : 0)
            .accessibilityAddTraits(.isHeader)
    }

    private func fontFor(level: Int) -> Font {
        let isPadLike = (hSize == .regular)

        switch level {
        case 1:
            return isPadLike
                ? .system(.largeTitle, weight: .bold)
                : .system(.title, weight: .bold)      // ✅ iPhone fix
        case 2:
            return .system(.title2, weight: .semibold)
        case 3:
            return .system(.headline, weight: .semibold)
        default:
            return .system(.headline, weight: .semibold)
        }
    }
}
