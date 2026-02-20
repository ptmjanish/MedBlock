//
//  HighlightStore.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI
import Combine

final class HighlightStore: ObservableObject {

    enum Highlight: String, CaseIterable, Identifiable, Codable {
        case none, yellow, green, blue, pink
        var id: String { rawValue }
    }

    @Published private(set) var map: [String: Highlight] = [:] {
        didSet { save() }
    }

    private let key = "highlights.v1"

    init() { load() }

    func highlight(for blockId: String) -> Highlight {
        map[blockId] ?? .none
    }

    func setHighlight(_ highlight: Highlight, for blockId: String) {
        if highlight == .none { map.removeValue(forKey: blockId) }
        else { map[blockId] = highlight }
    }

    func color(for blockId: String) -> Color {
        switch highlight(for: blockId) {
        case .none: return .clear
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .pink: return .pink
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        if let decoded = try? JSONDecoder().decode([String: Highlight].self, from: data) {
            map = decoded
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(map) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
