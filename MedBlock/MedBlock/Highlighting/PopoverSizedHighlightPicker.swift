//
//  PopoverSizedHighlightPicker.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//

import SwiftUI
import Foundation

struct PopoverSizedHighlightPicker: View {
    let current: HighlightStore.Highlight
    let onSelect: (HighlightStore.Highlight) -> Void

    @State private var contentHeight: CGFloat = 360

    var body: some View {
        HighlightPickerV2(current: current, onSelect: onSelect)
            .readSize { size in
                // Add extra breathing space for:
                // - popover arrow
                // - shadow
                // - internal padding
                let buffer: CGFloat = 60

                let desired = min(
                    max(size.height + buffer, 340), // minimum comfortable height
                    620                              // slightly higher cap
                )

                // Prevent layout thrashing
                if abs(desired - contentHeight) > 8 {
                    contentHeight = desired
                }
            }
            .frame(width: 500, height: contentHeight)
    }
}
