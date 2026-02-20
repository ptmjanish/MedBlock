//
//  UIFont+Traits.swift
//  MedBlock
//
//  Created by Mohammed Janish on 20/02/26.
//

import Foundation
import UIKit

extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits) ?? fontDescriptor
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
