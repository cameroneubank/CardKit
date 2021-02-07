# CardKit
## Playing cards, in Swift!

CardKit is a simple to use Swift framework for creating and working with playing cards.

## Features
- Create single cards, or a collection of cards in a card deck.
- Need six deck blackjack?  Card decks can be created with multiple decks.
- Need a deck with only hearts? Card decks can be created excluding one or many suits.
- Need a deck with only aces? Card decks can be created excluding one or many card values.
- Card decks can be preshuffled or have unshuffled cards ordered in accordance with the [USPCC](https://usplayingcard.com) specifications.

## Overview

### Card
`Card` is the primary entity of `CardKit`, and represents a single playing card. 
A `Card` can be instantiated via:
```
let aceOfSpades: Card = Card(suit: .spade, value: .ace)
```

### CardSuit
Every instance of `Card` has a suit, represented by `CardSuit`.

*Note: Jokers are represented by a special `CardSuit`, `CardSuit.joker`.*

### CardValue
Every instance of `Card` has a value, represented by `CardValue`.

*Note: Similar to `CardSuit`, jokers are represented by a special `CardSuit`, `CardValue.joker`.*

### CardDeck
`CardDeck` contains a collection of cards.

#### Building a standard `CardDeck`
To retrieve a standard instance of `CardDeck`, identical to a brand new physical deck of cards, call the static method `standard()`.
```
let cardDeck = CardDeck.standard()
```

#### Accessing a card from a `CardDeck`
To access a card from the deck, call `drawCard()` on the deck.
The next card in the deck is drawn and returned, if available.
```
let cardDeck = CardDeck.standard()
let card: Card = cardDeck.drawCard()
```

#### Shuffling cards in a `CardDeck`
The shuffle the cards in the deck, call `shuffle()` on the deck.
This method simply shuffles the cards remaining in the deck in place.
To draw a card from the newly shuffled deck, call `drawCard()` on the deck as you normally would.
```
let cardDeck = CardDeck.standard()
cardDeck.shuffle()
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

### CardDeck.Configuration
On many occasions, a `CardDeck` with the standard configuration is not appropriate.
`CardDeck` is configurable and can be instantiated with an instance of `CardDeck.Configuration`.

`CardDeck.Configuration` encapsulates the configurable properties of a `CardDeck`. Each property is shown below.
- numberOfDecks: The number of decks in a `CardDeck`.
- preshuffled: Determines if cards in a `CardDeck` are shuffled upon initialization.
- refillsWhenEmpty: Determines if cards in a `CardDeck` are refilled when the deck has no more cards and a new card attempted to be drawn.
- excludedCardValues: Any excluded `CardValue` values in a `CardDeck`.
- excludedCardSuits: Any excluded `CardSuit` values in a `CardDeck`.

#### Creating a `CardDeck` with no jokers
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 1,
                                                                   preshuffled: false,
                                                                   refillsWhenEmpty: false,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
```
#### Creating a `CardDeck`, preshuffled, with no jokers, which refills when empty
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 1,
                                                                   preshuffled: true,
                                                                   refillsWhenEmpty: true,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
```
#### Creating a six deck `CardDeck`, preshuffled, with no jokers, which refills when empty
```
let configuration: CardDeck.Configuration = CardDeck.Configuration(numberOfDecks: 6,
                                                                   preshuffled: true,
                                                                   refillsWhenEmpty: true,
                                                                   excludedCardValues: [.joker],
                                                                   excludedCardSuits: [.joker])
let cardDeck: CardDeck = CardDeck(configuration: configuration)
print(cardDeck.numberOfCards) // 312 cards
```
## Installation

CardKit is available via Swift Package Manager.
