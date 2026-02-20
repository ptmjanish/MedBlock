//
//  StudyDocument.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct StudyDocument: Decodable {
    let title: String
    let blocks: [ContentBlock]
}