//
//  MedBlockApp.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//

import SwiftUI

@main
struct MedBlockApp: App {
    
    init() {
        BlockRegistry.shared.registerDefaults()
    }
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                StudyScreen()
            }
        }
    }
}
