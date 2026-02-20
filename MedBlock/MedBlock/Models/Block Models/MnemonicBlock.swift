//
//  MnemonicBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct MnemonicBlock: Decodable {
    struct Letter: Decodable, Identifiable {
        let letter: String
        let expansion: String
        var id: String { "\(letter):\(expansion)" }
    }

    let type: String
    let title: String
    let letters: [Letter]
}