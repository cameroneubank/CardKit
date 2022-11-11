//
//  CardDeck.swift
//  CardKit
//
//  Created by Cameron Eubank on 2/7/21.
//

import Foundation

/// Allows for the responding to of certain events occurring within a `CardDeck`.
public protocol CardDeckDelegate: AnyObject {
    /// Called when the deck was refilled.
    func cardDeckDidRefill(_ deck: CardDeck)
}

/// Represents a deck of cards.
public class CardDeck {
    
    // MARK: - Initialization
    
    private let configuration: CardDeck.Configuration
    private var cards: [Card]
    
    /// Allows for the responding to of certain events occurring within the deck.
    public weak var delegate: CardDeckDelegate?
    
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
    
    /// Refills the cards in the deck based on its configuration.
    ///
    /// - note: **Any** cards still present in the deck will be removed and replaced.
    ///
    public func refill() {
        cards = CardDeck.createCards(from: configuration)
        delegate?.cardDeckDidRefill(self)
    }

    /// Returns the next card in the deck.
    ///
    /// Returns: The next instance of `Card`, if available.
    ///          The return value depends on the value of `refillsWhenEmpty` of `configuration` provided during initialization.
    ///          When `refillsWhenEmpty` is `true` and the deck is empty,
    ///          the deck is refilled using the `configuration` provided during initialization and a non-nil `Card` will always be returned. Additionally, the delegate's `cardDeckDidRefill(_:)` method will be invoked.
    ///          When `refillsWhenEmpty` is `false` and the deck is empty, `nil` will be returned.
    ///
    public func drawCard() -> Card? {
        guard !cards.isEmpty else {
            if configuration.refillsWhenEmpty {
                refill()
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
        (0..<configuration.numberOfDecks).forEach { _ in
            let filtered = ordered.filter { card in
                return !configuration.excludedCardValues.contains(card.value) &&
                       !configuration.excludedCardSuits.contains(card.suit)
            }
            cards.append(contentsOf: filtered)
        }
        return configuration.shuffled ? cards.shuffled() : cards
    }
    
    // MARK: - USPCC Ordering
    
    /// Returns the USPCC ordered array of `Card`s found in a "standard" deck.
    ///
    /// Source info: https://ambitiouswithcards.com/new-deck-order/
    ///
    /// USPCC: https://usplayingcard.com
    ///
    internal static let ordered: [Card] = {
        var cards = [Card]()
        orderedCardSuits.forEach { suit in
            orderedCardValues(for: suit).forEach { value in
                let card = Card(suit: suit, value: value)
                cards.append(card)
            }
        }
        return cards
    }()
    
    /// Returns the USPCC ordered array of `CardSuit`s in a "standard" deck.
    ///
    /// Source info: https://ambitiouswithcards.com/new-deck-order/
    ///
    /// USPCC: https://usplayingcard.com
    ///
    internal static let orderedCardSuits: [CardSuit] = {
        [.none, .spade, .diamond, .club, .heart]
    }()
    
    /// Returns the USPCC ordered array of `CardSuit`s in a "standard" deck.
    ///
    /// - parameter suit: The `CardSuit` to obtain the order card values of.
    /// - returns: The USPCC ordered array of `CardSuit`s in a "standard" deck for the provided suit.
    ///
    /// Source info: https://ambitiouswithcards.com/new-deck-order/
    ///
    /// USPCC: https://usplayingcard.com
    ///
    internal static func orderedCardValues(for suit: CardSuit) -> [CardValue] {
        switch suit {
        case .none: return [.joker, .joker]
        case .spade, .diamond:
            return [.ace, .two, .three,
                    .four, .five, .six,
                    .seven, .eight, .nine, .ten,
                    .jack, .queen, .king]
        case .club, .heart:
            return [.two, .three,
                    .four, .five, .six,
                    .seven, .eight, .nine, .ten,
                    .jack, .queen, .king, .ace]
        }
    }
}

// MARK: - Convenience Decks

public extension CardDeck {
    
    /// Returns an instance of `CardDeck` with a standard configuration according to the `USPCC`.
    ///
    /// Contains an unshuffled single deck of cards with no excluded cards.
    /// The deck does **not** automatically refill when the deck has no more cards and a new card is attempted to be drawn.
    ///
    static func standard() -> CardDeck {
        let configuration = Configuration(numberOfDecks: 1,
                                          shuffled: false,
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
        internal let numberOfDecks: Int
        internal let shuffled: Bool
        internal let refillsWhenEmpty: Bool
        internal let excludedCardValues: [CardValue]
        internal let excludedCardSuits: [CardSuit]
        
        /// Initialize an instance of `CardDeck.Configuration`.
        ///
        /// - parameter numberOfDecks: The number of decks in a `CardDeck`.
        /// - parameter shuffled: Determines if cards in a `CardDeck` are shuffled upon initialization.
        /// - parameter refillsWhenEmpty: Determines if cards in a `CardDeck` are automatically refilled when the deck has no more cards and a new card attempted to be drawn.
        /// - parameter excludedCardValues: Any excluded `CardValue` values in a `CardDeck`.
        /// - parameter excludedCardSuits: Any excluded `CardSuit` values in a `CardDeck`.
        ///
        public init(numberOfDecks: Int,
                    shuffled: Bool,
                    refillsWhenEmpty: Bool,
                    excludedCardValues: [CardValue],
                    excludedCardSuits: [CardSuit]) {
            self.numberOfDecks = numberOfDecks
            self.shuffled = shuffled
            self.refillsWhenEmpty = refillsWhenEmpty
            self.excludedCardValues = excludedCardValues
            self.excludedCardSuits = excludedCardSuits
        }
    }
}

