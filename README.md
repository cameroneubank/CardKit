# CardKit
## Playing cards, in Swift!

`CardKit` is a simple to use Swift framework for creating and working with playing cards.

## Features
- Create single a card or a collection of cards in a deck of cards.
- Need six deck Blackjack? A deck of cards can be created with n number of decks.
- Need a deck with only hearts? Card decks can be created excluding one or many suits.
- Need a deck with only aces? Card decks can be created excluding one or many card values.
- Card decks can be preshuffled or have unshuffled cards ordered in accordance with [USPCC](https://usplayingcard.com) specifications.

## API Overview

### Card
`Card` is the primary entity of `CardKit` and represents a single playing card.

A `Card` can be instantiated via:
```
let aceOfSpades: Card = Card(suit: .spade, value: .ace)
```

### CardSuit
Every instance of `Card` has a suit, represented by `CardSuit`.

*Note: Jokers are represented by a special `CardSuit`, `CardSuit.none`.*

### CardValue
Every instance of `Card` has a value, represented by `CardValue`.

This can be thought of as "face" or "display" value, and **not** a number.

*Note: Similar to `CardSuit`, jokers are represented by a special `CardValue`, `CardValue.joker`.*

### CardDeck
`CardDeck` contains a collection of cards.

#### Building a standard `CardDeck`
To retrieve a standard instance of `CardDeck`, identical to a brand new physical deck of US cards, call the static method `standard()`.
```
let cardDeck = CardDeck.standard()
```

#### Accessing a card from a `CardDeck`
To access a card from the deck, call `drawCard()` on the deck.
The next card in the deck is drawn and returned, if available.

*Note: If there are no more cards in the deck, and `refillsWhenEmpty` of `CardDeck.Configuration` is `false`, `nil` will be returned.*

```
let cardDeck = CardDeck.standard()
let card: Card = cardDeck.drawCard()
```

#### Determining the number of cards in a `CardDeck`
The number of cards in a `CardDeck` can be identified by the `numberOfCards` property.
```
let cardDeck = CardDeck.standard()

// Are we running low on cards?
if cardDeck.numberOfCards == 3 {
    showLowCardsAlert()
}
```

#### Refilling cards in a `CardDeck`
To refill the cards in a deck, call `refill()` on the deck.
This method refills the cards in the deck based on its original configuration.
```
let cardDeck = CardDeck.standard()
cardDeck.refill()
let card: Card = cardDeck.drawCard() // A "new" card from a newly refilled deck.
```

Alternatively, see `CardDeck.Configuration`'s `refillsWhenEmpty` property to achieve this behavior automatically.

### CardDeckDelegate

A deck delegates out certain events that occur within the lifespan of a`CardDeck`.

You may consider conforming to this protocol if warranted.


```
final class MyClass {
    let deck = CardDeck.standard()
    
    init() {
        deck.delegate = self
    }
}

// MARK: - CardDeckDelegate

extension MyClass: CardDeckDelegate {
    func cardDeckDidRefill(_ deck: CardDeck) {
        // React to when a card deck refills.
        // This may be especially useful when CardDeck.Configuration's refillsWhenEmpty is true!
    }
}
```

### CardDeck.Configuration
Depending on your use case, a `CardDeck` with the standard configuration may not be appropriate. A
`CardDeck` is configurable and can be instantiated with an instance of `CardDeck.Configuration`.

`CardDeck.Configuration` encapsulates the configurable properties of a `CardDeck`. Each property is shown below.
- numberOfDecks: The number of decks in a `CardDeck`.
- shuffled: Determines if cards in a `CardDeck` are shuffled upon initialization.
- refillsWhenEmpty: Determines if cards in a `CardDeck` are **automatically** refilled when the deck has no more cards and a new card attempted to be drawn.
- excludedCardValues: Any excluded `CardValue` values in a `CardDeck`.
- excludedCardSuits: Any excluded `CardSuit` values in a `CardDeck`.

#### Creating a `CardDeck` with no jokers
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 1,
                                                                   shuffled: false,
                                                                   refillsWhenEmpty: false,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
```
#### Creating a `CardDeck`, preshuffled, with no jokers, which refills when empty
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 1,
                                                                   shuffled: true,
                                                                   refillsWhenEmpty: true,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
```
#### Creating a six deck `CardDeck`, preshuffled, with no jokers, which refills when empty
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 6,
                                                                   shuffled: true,
                                                                   refillsWhenEmpty: true,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
print(cardDeck.numberOfCards) // 312 cards
```

## Installation

CardKit is available via Swift Package Manager.
