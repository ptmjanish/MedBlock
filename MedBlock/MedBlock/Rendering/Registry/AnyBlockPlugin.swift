//
//  AnyBlockPlugin.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct AnyBlockPlugin {
    let type: String
    let decode: (Decoder) throws -> any StudyBlockValue
    let render: (String, any StudyBlockValue) -> AnyView
}

final class BlockRegistry {
    static let shared = BlockRegistry()
    private init() {}

    private var plugins: [String: AnyBlockPlugin] = [:]

    func register(_ plugin: AnyBlockPlugin) {
        plugins[plugin.type] = plugin
    }

    func plugin(for type: String) -> AnyBlockPlugin? {
        plugins[type]
    }

    func render(block: AnyStudyBlock) -> AnyView {
        guard let plugin = plugins[block.type] else {
            return AnyView(UnknownBlockView(type: block.type))
        }
        return plugin.render(block.id, block.value)
    }
}


extension BlockRegistry {
    func registerDefaults() {
        register(HeadingBlockPlugin.plugin)
        register(ParagraphBlockPlugin.plugin)
        register(ComparisonBlockPlugin.plugin)
        register(MnemonicBlockPlugin.plugin)
        register(CalloutBlockPlugin.plugin)
        register(ListBlockPlugin.plugin)
    }
}
