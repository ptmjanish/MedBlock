//
//  HeadingBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum HeadingBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "heading",
        decode: { decoder in
            try HeadingBlock(from: decoder)
        },
        render: { blockId, value in
            let block = value as! HeadingBlock
            return AnyView(HeadingBlockView(block: block))
        }
    )
}