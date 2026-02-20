//
//  CalloutBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct CalloutBlock: Decodable, StudyBlockValue {
    enum Style: String, Decodable {
        case warning, tip, info
    }

    let type: String
    let style: Style
    let title: String
    let text: String
}
