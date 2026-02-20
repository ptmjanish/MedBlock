//
//  TestPluginBoot.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation
@testable import MedBlock

enum TestPluginBoot {
    private static var didRegister = false

    static func registerIfNeeded() {
        guard !didRegister else { return }
        didRegister = true

        BlockRegistry.shared.register(HeadingBlockPlugin.plugin)
        BlockRegistry.shared.register(ParagraphBlockPlugin.plugin)
        BlockRegistry.shared.register(ComparisonBlockPlugin.plugin)
        BlockRegistry.shared.register(MnemonicBlockPlugin.plugin)
        BlockRegistry.shared.register(CalloutBlockPlugin.plugin)
        BlockRegistry.shared.register(ListBlockPlugin.plugin)
    }
}