//
//  ReadingContainer.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct ReadingContainer<Content: View>: View {
    @Environment(\.sizeCategory) private var sizeCategory
    @ViewBuilder let content: Content

    var body: some View {
        HStack {
            Spacer(minLength: 0)
            VStack(alignment: .leading, spacing: DS.blockSpacing(sizeCategory)) {
                content
            }
            .frame(maxWidth: DS.pageMaxWidth, alignment: .leading)
            .padding(.horizontal, DS.pagePadding(sizeCategory))
            .padding(.vertical, 18)
            Spacer(minLength: 0)
        }
    }
}
