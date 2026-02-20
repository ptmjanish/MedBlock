//
//  ListBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct ListBlock: Decodable {
    let type: String
    let ordered: Bool
    let items: [String]
}