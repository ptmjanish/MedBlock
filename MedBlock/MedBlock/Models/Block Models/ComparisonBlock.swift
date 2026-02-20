//
//  ComparisonBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct ComparisonBlock: Decodable, StudyBlockValue {
    struct Column: Decodable, Identifiable, Sendable {
        struct Item: Decodable, Identifiable, Sendable {
            let label: String
            let value: String
            var id: String { "\(label)|\(value)" }
        }

        let title: String
        let items: [Item]
        var id: String { title }
    }

    let columns: [Column]
}
