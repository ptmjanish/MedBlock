//
//  ParagraphBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct ParagraphSpan: Decodable, Sendable {
    let text: String
    let bold: Bool
}

struct ParagraphBlock: Decodable, StudyBlockValue {
    let content: [ParagraphSpan]
}
