//
//  StudyDocumentDecoder.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

enum StudyDocumentDecoder {
    static func decode(from data: Data) throws -> StudyDocument {
        let decoder = JSONDecoder()
        return try decoder.decode(StudyDocument.self, from: data)
    }

    static func decode(from jsonString: String) throws -> StudyDocument {
        try decode(from: Data(jsonString.utf8))
    }
}