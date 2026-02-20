//
//  HeadingBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct HeadingBlock: Decodable {
    let type: String
    let level: Int
    let text: String
}