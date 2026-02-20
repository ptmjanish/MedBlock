//
//  CalloutBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum CalloutBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "callout",
        decode: { decoder in
            try CalloutBlock(from: decoder)
        },
        render: { _, value in
            AnyView(CalloutBlockView(block: value as! CalloutBlock))
        }
    )
}