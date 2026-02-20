//
//  HeadingBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct HeadingBlock: Decodable, StudyBlockValue {
    let type: String
    let level: Int
    let text: String
}
