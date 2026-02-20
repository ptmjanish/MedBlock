//
//  StudyBlockValue.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

protocol StudyBlockValue: Sendable { }   // marker protocol

struct AnyStudyBlock: Identifiable, Sendable {
    // IMPORTANT: stable IDs for highlight persistence
    // We'll assign these after decoding using index in StudyDocument.
    var id: String

    let type: String
    let value: any StudyBlockValue
}