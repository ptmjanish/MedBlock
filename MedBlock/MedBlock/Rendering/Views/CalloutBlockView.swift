//
//  CalloutBlockView.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//


import SwiftUI

struct CalloutBlockView: View {
    let block: CalloutBlock

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconName)
                .font(.title3)
                .foregroundStyle(iconColor)

            VStack(alignment: .leading, spacing: 6) {
                Text(block.title).font(.headline)
                Text(block.text).font(.body).lineSpacing(3)
            }
        }
        .padding(12)
        .background(bgColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor.opacity(0.35), lineWidth: 1)
        )
        .accessibilityElement(children: .combine)
    }

    private var iconName: String {
        switch block.style {
        case .warning: return "exclamationmark.triangle.fill"
        case .tip: return "lightbulb.fill"
        case .info: return "info.circle.fill"
        }
    }

    private var iconColor: Color {
        switch block.style {
        case .warning: return .orange
        case .tip: return .green
        case .info: return .blue
        }
    }

    private var bgColor: Color {
        switch block.style {
        case .warning: return Color.orange.opacity(0.12)
        case .tip: return Color.green.opacity(0.12)
        case .info: return Color.blue.opacity(0.12)
        }
    }

    private var borderColor: Color { iconColor }
}