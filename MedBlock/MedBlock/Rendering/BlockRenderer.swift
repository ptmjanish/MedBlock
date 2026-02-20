//
//  BlockRenderer.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct BlockRenderer: View {
    let block: ContentBlock

    var body: some View {
        switch block {
        case .heading(let b):
            HeadingBlockView(block: b)
        case .paragraph(let b):
            ParagraphBlockView(blockId: block.id, block: b)
        case .comparison(let b):
            ComparisonBlockView(block: b)
        case .mnemonic(let b):
            MnemonicBlockView(block: b)
        case .callout(let b):
            CalloutBlockView(block: b)
        case .list(let b):
            ListBlockView(block: b)
        }
    }
}