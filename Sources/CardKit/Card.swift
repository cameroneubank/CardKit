//
//  Card.swift
//  CardKit
//
//  Created by Cameron Eubank on 2/7/21.
//

import Foundation
import UIKit

/// Represents a single card.
public struct Card: Equatable {
    public let suit: CardSuit
    public let value: CardValue
    
    /// Initialze an instance of `Card`.
    ///
    /// - parameter suit: The `CardSuit` of the card.
    /// - parameter value: The `CardValue` of the card.
    ///
    public init(suit: CardSuit, value: CardValue) {
        self.suit = suit
        self.value = value
    }
}
