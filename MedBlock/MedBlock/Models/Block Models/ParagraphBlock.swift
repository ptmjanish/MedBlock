//
//  ParagraphBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct ParagraphBlock: Decodable {
    struct Span: Decodable {
        let text: String
        let bold: Bool
    }

    let type: String
    let content: [Span]
}