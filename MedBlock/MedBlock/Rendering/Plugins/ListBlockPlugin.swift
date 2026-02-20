//
//  ListBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum ListBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "list",
        decode: { decoder in
            try ListBlock(from: decoder)
        },
        render: { _, value in
            AnyView(ListBlockView(block: value as! ListBlock))
        }
    )
}