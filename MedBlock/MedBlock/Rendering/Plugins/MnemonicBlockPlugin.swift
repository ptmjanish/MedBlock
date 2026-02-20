//
//  MnemonicBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

enum MnemonicBlockPlugin {
    static let plugin = AnyBlockPlugin(
        type: "mnemonic",
        decode: { decoder in
            try MnemonicBlock(from: decoder)
        },
        render: { _, value in
            AnyView(MnemonicBlockView(block: value as! MnemonicBlock))
        }
    )
}