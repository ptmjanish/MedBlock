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
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(doc.blocks) { block in
                            BlockRenderer(block: block)
                                .environmentObject(highlightStore)
                                .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 18)
                }
                .navigationTitle(doc.title)
                .navigationBarTitleDisplayMode(.inline)
                .animation(.easeInOut(duration: 0.25), value: doc.blocks.count)
            } else if let err = errorText {
                ContentUnavailableView("Failed to load", systemImage: "exclamationmark.triangle", description: Text(err))
            } else {
                ProgressView("Loading…")
                    .task { load() }
            }
        }
    }

    private func load() {
        do {
            document = try JSONLoader.loadBundledDocument(named: "StudyContent")
        } catch {
            errorText = error.localizedDescription
        }
    }
}