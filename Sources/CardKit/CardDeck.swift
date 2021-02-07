//
//  CardDeck.swift
//  CardKit
//
//  Created by Cameron Eubank on 2/7/21.
//

import Foundation

/// Represents a deck of cards.
public class CardDeck {
    
    // MARK: - Initialization
    
    private let configuration: CardDeck.Configuration
    private var cards: [Card]
    
    /// Initialize an instance of `CardDeck`.
    ///
    /// - parameter configuration: The instance of `CardDeck.Configuration` to configure the deck with.
    ///
    public init(configuration: CardDeck.Configuration) {
        self.configuration = configuration
        self.cards = CardDeck.createCards(from: configuration)
    }
    
    // MARK: - Public
    
    /// Returns the number of cards remaining in the deck as `Int`.
    public var numberOfCards: Int {
        cards.count
    }
    
    /// Shuffles the cards in a deck.
    public func shuffle() {
        cards.shuffle()
    }

    /// Returns the next card in the deck.
    ///
    /// Returns: The next instance of `Card`, if available.
    ///          The return value depends on the value of `refillsWhenEmpty` of `configuration` provided during intitialization.
    ///          When `refillsWhenEmpty` is `true` and the deck is empty,
    ///          the deck is refilled using the `configuration` provided during initialization and a non-nil `Card` will always be returned.
    ///          When `refillsWhenEmpty` is `false` and the deck is empty,
    ///          `nil` will be returned.
    ///
    public func drawCard() -> Card? {
        guard !cards.isEmpty else {
            if configuration.refillsWhenEmpty {
                cards = CardDeck.createCards(from: configuration)
                return drawCard()
            } else {
                return nil
            }
        }
        return cards.removeFirst()
    }

    // MARK: - Private
    
    private static func createCards(from configuration: CardDeck.Configuration) -> [Card] {
        var cards = [Card]()
        let unshuffuledIncludedSuits: [CardSuit] = CardSuit.allCases.filter { !configuration.excludedCardSuits.contains($0) }
        (0..<configuration.numberOfDecks).forEach { _ in
            unshuffuledIncludedSuits.forEach { suit in
                let unshuffuledIncludedValues: [CardValue] = CardValue.unshuffledOrder(for: suit).filter { !configuration.excludedCardValues.contains($0) }
                unshuffuledIncludedValues.forEach { value in
                    let card = Card(suit: suit, value: value)
                    cards.append(card)
                }
            }
        }
        if configuration.preshuffled {
            cards.shuffle()
        }
        return cards
    }
}

// MARK: - Convenience Decks

public extension CardDeck {
    
    /// Returns an instance of `CardDeck` with a standard configuration.
    ///
    /// Contains an unshuffled single deck of cards with no excluded cards.
    /// The deck does not automatically refill when the deck has no more cards and a new card is attempted to be drawn.
    ///
    static func standard() -> CardDeck {
        let configuration = Configuration(numberOfDecks: 1,
                                          preshuffled: false,
                                          refillsWhenEmpty: false,
                                          excludedCardValues: [],
                                          excludedCardSuits: [])
        return CardDeck(configuration: configuration)
    }
}

// MARK: - CardDeck.Configuration

public extension CardDeck {
    /// The configuration of a `CardDeck`.
    struct Configuration {
        /// The number of decks in a `CardDeck`.
        internal let numberOfDecks: Int
        /// Determines if cards in a `CardDeck` are shuffled upon initialization.
        internal let preshuffled: Bool
        /// Determines if cards in a `CardDeck` are refilled when the deck has no more cards and a new card attempted to be drawn.
        internal let refillsWhenEmpty: Bool
        /// Any excluded `CardValue` values in a `CardDeck`.
        internal let excludedCardValues: [CardValue]
        /// Any excluded `CardSuit` values in a `CardDeck`.
        internal let excludedCardSuits: [CardSuit]
        
        /// Initialize an instance of `CardDeck.Configuration`.
        ///
        /// - parameter numberOfDecks: The number of decks in a `CardDeck`.
        /// - parameter preshuffled: Determines if cards in a `CardDeck` are shuffled upon initialization.
        /// - parameter refillsWhenEmpty: Determines if cards in a `CardDeck` are refilled when the deck has no more cards and a new card attempted to be drawn.
        /// - parameter excludedCardValues: Any excluded `CardValue` values in a `CardDeck`.
        /// - parameter excludedCardSuits: Any excluded `CardSuit` values in a `CardDeck`.
        ///
        public init(numberOfDecks: Int,
                    preshuffled: Bool,
                    refillsWhenEmpty: Bool,
                    excludedCardValues: [CardValue],
                    excludedCardSuits: [CardSuit]) {
            self.numberOfDecks = numberOfDecks
            self.preshuffled = preshuffled
            self.refillsWhenEmpty = refillsWhenEmpty
            self.excludedCardValues = excludedCardValues
            self.excludedCardSuits = excludedCardSuits
        }
    }
}

