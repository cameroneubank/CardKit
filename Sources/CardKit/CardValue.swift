//
//  CardValue.swift
//  CardKit
//
//  Created by Cameron Eubank on 2/7/21.
//

import Foundation

/// Represents the value of a card.
public enum CardValue {
    case joker
    case ace
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
}

extension CardValue {
    
    /// Returns the USPCC ordered array of `CardValue` for a given suit.
    ///
    /// - parameter suit: The `CardSuit` to derive the ordered `CardValue`s of.
    ///
    /// returns: The ordered array of `CardValue` for the given suit.
    ///
    /// Source info: https://ambitiouswithcards.com/new-deck-order/
    /// USPCC: https://usplayingcard.com
    ///
    internal static func unshuffledOrder(for suit: CardSuit) -> [CardValue] {
        switch suit {
        case .joker: return [.joker, .joker]
        case .spade, .diamond:
            return [.ace, .two, .three,
                    .four, .five, .six,
                    .seven, .eight, .nine, .ten,
                    .jack, .queen, .king]
        case .club, .heart:
            // The reverse of club or spade, in reverse.
            return CardValue.unshuffledOrder(for: .spade).reversed()
        }
    }
}
