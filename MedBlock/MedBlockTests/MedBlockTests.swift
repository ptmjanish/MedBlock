//
//  MedBlockTests.swift
//  MedBlockTests
//
//  Created by Mohammed Janish on 20/02/26.
//

import Testing
import Foundation
@testable import MedBlock

struct MedBlockTests {

    @Test
    func decodesTitleAndBlockCount() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)

        #expect(doc.title == "Pemphigus vs Bullous Pemphigoid")
        #expect(doc.blocks.count == 8)
    }

    @Test
    func decodesHeadingBlock() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let heading = doc.blocks.first(where: { $0.type == "heading" })

        #expect(heading != nil)

        let value = heading?.value as? HeadingBlock
        #expect(value != nil)
        #expect(value?.level == 1)
        #expect(value?.text == "Blistering Skin Diseases")
    }

    @Test
    func decodesParagraphSpans() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let paragraph = doc.blocks.first(where: { $0.type == "paragraph" })
        let value = paragraph?.value as? ParagraphBlock

        #expect(value != nil)
        #expect(value?.content.count == 3)
        #expect(value?.content[1].text == "distinct pathophysiology")
        #expect(value?.content[1].bold == true)
    }

    @Test
    func decodesComparisonColumns() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let comp = doc.blocks.first(where: { $0.type == "comparison" })
        let value = comp?.value as? ComparisonBlock

        #expect(value != nil)
        #expect(value?.columns.count == 2)
        #expect(value?.columns.first?.title == "Pemphigus Vulgaris")

        let pvLayer = value?.columns.first?.items.first(where: { $0.label == "Layer" })
        #expect(pvLayer?.value == "Intraepidermal")
    }

    @Test
    func decodesMnemonicBlock() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let mnemonic = doc.blocks.first(where: { $0.type == "mnemonic" })
        let value = mnemonic?.value as? MnemonicBlock

        #expect(value != nil)
        #expect(value?.title == "Remember BLISTERS")
        #expect(value?.letters.count == 8)
        #expect(value?.letters.first?.letter == "B")
    }

    @Test
    func decodesCalloutBlock() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let callouts = doc.blocks.filter { $0.type == "callout" }

        #expect(callouts.count == 2)

        let warning = callouts.compactMap { $0.value as? CalloutBlock }.first(where: { $0.style == .warning })
        #expect(warning != nil)
        #expect(warning?.title == "High Yield")
        #expect(warning?.text.contains("Nikolsky") == true)
    }

    @Test
    func decodesOrderedAndUnorderedLists() throws {
        TestPluginBoot.registerIfNeeded()

        let doc = try StudyDocumentDecoder.decode(json: Fixtures.sampleJSON)
        let lists = doc.blocks.compactMap { $0.value as? ListBlock }

        #expect(lists.count == 2)

        let unordered = lists.first(where: { $0.ordered == false })
        #expect(unordered?.items.first == "First-line treatment: Systemic corticosteroids")

        let ordered = lists.first(where: { $0.ordered == true })
        #expect(ordered?.items.count == 5)
        #expect(ordered?.items.last == "Taper based on clinical response")
    }

    @Test
    func unknownBlockTypeDoesNotCrash() throws {
        TestPluginBoot.registerIfNeeded()

        let json = """
        {
          "title": "Test Unknown",
          "blocks": [
            { "type": "heading", "level": 1, "text": "Hello" },
            { "type": "alien_block", "foo": "bar" }
          ]
        }
        """

        let doc = try StudyDocumentDecoder.decode(json: json)

        #expect(doc.blocks.count == 2)
        #expect(doc.blocks[1].type == "alien_block")

        // It should NOT masquerade as known blocks
        #expect((doc.blocks[1].value as? HeadingBlock) == nil)
        #expect((doc.blocks[1].value as? ParagraphBlock) == nil)
    }
}

// MARK: - Fixtures
enum Fixtures {
    static let sampleJSON = """
    {
      "title": "Pemphigus vs Bullous Pemphigoid",
      "blocks": [
        {
          "type": "heading",
          "level": 1,
          "text": "Blistering Skin Diseases"
        },
        {
          "type": "paragraph",
          "content": [
            { "text": "Two major autoimmune blistering conditions with ", "bold": false },
            { "text": "distinct pathophysiology", "bold": true },
            { "text": " that are frequently tested in medical examinations.", "bold": false }
          ]
        },
        {
          "type": "comparison",
          "columns": [
            {
              "title": "Pemphigus Vulgaris",
              "items": [
                { "label": "Layer", "value": "Intraepidermal" },
                { "label": "Antibody", "value": "Anti-desmoglein 3" },
                { "label": "Sign", "value": "Nikolsky (+)" },
                { "label": "Blister", "value": "Flaccid" },
                { "label": "Age Group", "value": "Middle-aged" }
              ]
            },
            {
              "title": "Bullous Pemphigoid",
              "items": [
                { "label": "Layer", "value": "Subepidermal" },
                { "label": "Antibody", "value": "Anti-BP180 / BP230" },
                { "label": "Sign", "value": "Nikolsky (-)" },
                { "label": "Blister", "value": "Tense" },
                { "label": "Age Group", "value": "Elderly" }
              ]
            }
          ]
        },
        {
          "type": "mnemonic",
          "title": "Remember BLISTERS",
          "letters": [
            { "letter": "B", "expansion": "Bullae — fluid-filled lesions" },
            { "letter": "L", "expansion": "Layer — subepidermal vs intraepidermal" },
            { "letter": "I", "expansion": "Immunofluorescence pattern" },
            { "letter": "S", "expansion": "Sign — Nikolsky" },
            { "letter": "T", "expansion": "Target antigen differs" },
            { "letter": "E", "expansion": "Elderly (BP) vs Middle-aged (PV)" },
            { "letter": "R", "expansion": "Roof intact (BP) vs flaccid (PV)" },
            { "letter": "S", "expansion": "Steroids as first-line treatment" }
          ]
        },
        {
          "type": "callout",
          "style": "warning",
          "title": "High Yield",
          "text": "Pemphigus = flaccid blisters, Nikolsky (+). Pemphigoid = tense blisters, Nikolsky (-)."
        },
        {
          "type": "callout",
          "style": "tip",
          "title": "Memory Aid",
          "text": "PemphiGUS — Grave, the blisters are so fragile the roof caves in (flaccid). PemphiGOID — GOod roof, tense and intact."
        },
        {
          "type": "list",
          "ordered": false,
          "items": [
            "First-line treatment: Systemic corticosteroids",
            "Steroid-sparing agents: Azathioprine, Mycophenolate",
            "Rituximab for refractory cases",
            "Wound care and infection prevention"
          ]
        },
        {
          "type": "list",
          "ordered": true,
          "items": [
            "Obtain skin biopsy for histology",
            "Perform direct immunofluorescence",
            "Check serum antibody titers",
            "Initiate corticosteroid therapy",
            "Taper based on clinical response"
          ]
        }
      ]
    }
    """
}
