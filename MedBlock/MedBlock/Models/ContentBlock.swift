//
//  ContentBlock.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

enum ContentBlock: Decodable, Identifiable {
    case heading(HeadingBlock)
    case paragraph(ParagraphBlock)
    case comparison(ComparisonBlock)
    case mnemonic(MnemonicBlock)
    case callout(CalloutBlock)
    case list(ListBlock)

    var id: String {
        // Stable-ish id so highlights can persist even after reload.
        // Ideally JSON has ids, but since it doesn't, we derive.
        switch self {
        case .heading(let b): return "heading:\(b.level):\(b.text)"
        case .paragraph(let b): return "paragraph:\(b.content.map{$0.text}.joined())"
        case .comparison(let b): return "comparison:\(b.columns.map{$0.title}.joined(separator: "|"))"
        case .mnemonic(let b): return "mnemonic:\(b.title)"
        case .callout(let b): return "callout:\(b.style.rawValue):\(b.title)"
        case .list(let b): return "list:\(b.ordered ? "ordered" : "unordered"):\(b.items.joined(separator: "|"))"
        }
    }

    private enum CodingKeys: String, CodingKey { case type }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "heading":
            self = .heading(try HeadingBlock(from: decoder))
        case "paragraph":
            self = .paragraph(try ParagraphBlock(from: decoder))
        case "comparison":
            self = .comparison(try ComparisonBlock(from: decoder))
        case "mnemonic":
            self = .mnemonic(try MnemonicBlock(from: decoder))
        case "callout":
            self = .callout(try CalloutBlock(from: decoder))
        case "list":
            self = .list(try ListBlock(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .type,
                in: container,
                debugDescription: "Unknown block type: \(type)"
            )
        }
    }
}