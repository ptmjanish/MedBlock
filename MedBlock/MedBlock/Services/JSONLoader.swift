//
//  JSONLoader.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

enum JSONLoader {
    static func loadBundledDocument(named name: String) throws -> StudyDocument {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 404, userInfo: [NSLocalizedDescriptionKey: "Missing \(name).json in bundle"])
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(StudyDocument.self, from: data)
    }
}