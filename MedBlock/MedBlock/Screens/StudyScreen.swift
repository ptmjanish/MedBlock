//
//  StudyScreen.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct StudyScreen: View {
    @State private var document: StudyDocument? = nil
    @State private var errorText: String? = nil

    @StateObject private var highlightStore = HighlightStore()

    var body: some View {
        Group {
            if let doc = document {
                ScrollView {
                    ReadingContainer {
                        ForEach(Array(doc.blocks.enumerated()), id: \.element.id) { idx, block in
                            BlockRenderer(block: block)
                                .appearAnimated(index: idx, enabled: true)
                                .environmentObject(highlightStore)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                }
//                .navigationTitle(doc.title)
                .modifier(AdaptiveNavTitleStyle())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(doc.title)
                            .font(.headline.weight(.semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .background(DS.surface(.base))
                .animation(.easeInOut(duration: 0.25), value: doc.blocks.count)

            } else if let err = errorText {
                ContentUnavailableView("Failed to load",
                                       systemImage: "exclamationmark.triangle",
                                       description: Text(err))
            } else {
                ProgressView("Loading…")
                    .task { load() }
            }
        }
    }

    private func load() {
        do { document = try JSONLoader.loadBundledDocument(named: "StudyContent") }
        catch { errorText = error.localizedDescription }
    }
}



struct AdaptiveNavTitleStyle: ViewModifier {
    @Environment(\.horizontalSizeClass) private var hSize

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(hSize == .regular ? .large : .inline)
    }
}
