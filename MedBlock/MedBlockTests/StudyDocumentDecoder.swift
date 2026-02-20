//
//  StudyDocumentDecoder.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation
@testable import MedBlock

enum StudyDocumentDecoder {
    static func decode(json: String) throws -> StudyDocument {
        let data = Data(json.utf8)
        return try JSONDecoder().decode(StudyDocument.self, from: data)
    }
}