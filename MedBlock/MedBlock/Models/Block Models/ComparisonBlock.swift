//
//  ComparisonBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct ComparisonBlock: Decodable {
    struct Column: Decodable, Identifiable {
        struct Item: Decodable, Identifiable {
            let label: String
            let value: String
            var id: String { "\(label):\(value)" }
        }

        let title: String
        let items: [Item]
        var id: String { title }
    }

    let type: String
    let columns: [Column]
}