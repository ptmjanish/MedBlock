//
//  ComparisonBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum ComparisonBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "comparison",
        decode: { decoder in
            try ComparisonBlock(from: decoder)
        },
        render: { _, value in
            let block = value as! ComparisonBlock
            return AnyView(ComparisonBlockView(block: block))
        }
    )
}