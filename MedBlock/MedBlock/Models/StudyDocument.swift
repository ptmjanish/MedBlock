//
//  StudyDocument.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import Foundation

struct StudyDocument: Decodable {
    let title: String
    let blocks: [AnyStudyBlock]

    private enum CodingKeys: String, CodingKey {
        case title, blocks
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)

        // Decode blocks using a helper wrapper
        var blocksContainer = try container.nestedUnkeyedContainer(forKey: .blocks)
        var temp: [AnyStudyBlock] = []
        temp.reserveCapacity(blocksContainer.count ?? 0)

        var index = 0
        while !blocksContainer.isAtEnd {
            let wrapper = try blocksContainer.decode(BlockWrapper.self)
            // stable ID: type-index (works as long as JSON order is stable)
            let stableId = "\(wrapper.type)-\(index)"
            temp.append(AnyStudyBlock(id: stableId, type: wrapper.type, value: wrapper.value))
            index += 1
        }

        blocks = temp
    }

    private struct BlockWrapper: Decodable {
        let type: String
        let value: any StudyBlockValue

        private enum CodingKeys: String, CodingKey { case type }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            type = try c.decode(String.self, forKey: .type)

            guard let plugin = BlockRegistry.shared.plugin(for: type) else {
                // If unknown, keep a placeholder payload so decode doesn't crash
                value = UnknownBlockPayload()
                return
            }
            value = try plugin.decode(decoder)
        }
    }

    private struct UnknownBlockPayload: StudyBlockValue { }
}
