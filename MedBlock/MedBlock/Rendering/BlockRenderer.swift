//
//  BlockRenderer.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct BlockRenderer: View {
    let block: AnyStudyBlock

    var body: some View {
        BlockRegistry.shared.render(block: block)
    }
}
