//
//  AdaptiveHighlightPicker.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct AdaptiveHighlightPicker: ViewModifier {
    @Binding var isPresented: Bool
    let current: HighlightStore.Highlight
    let onSelect: (HighlightStore.Highlight) -> Void

    @Environment(\.horizontalSizeClass) private var hSize

    func body(content: Content) -> some View {
        let usePopover = (hSize == .regular)

        return content
            .sheet(isPresented: Binding(
                get: { isPresented && !usePopover },
                set: { newValue in if !newValue { isPresented = false } }
            )) {
                HighlightPickerV2(current: current, onSelect: onSelect)
                    .presentationDetents([.height(360), .medium]) // ✅ more breathing room
                    .presentationDragIndicator(.visible)
            }
            .popover(
                isPresented: Binding(
                    get: { isPresented && usePopover },
                    set: { newValue in if !newValue { isPresented = false } }
                ),
                attachmentAnchor: .point(.center),
                arrowEdge: .none
            ) {
                PopoverSizedHighlightPicker(current: current, onSelect: onSelect)
                    .padding()
            }    }
}
