//
//  ParagraphBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum ParagraphBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "paragraph",
        decode: { decoder in
            try ParagraphBlock(from: decoder)
        },
        render: { blockId, value in
            let block = value as! ParagraphBlock
            return AnyView(ParagraphBlockView(blockId: blockId, block: block))
        }
    )
}