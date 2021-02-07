//
//  CardDeckTest+SpadesOnly.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

final class CardDeckTest_SpadesOnly: CardDeckTest {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = CardDeck.Configuration(numberOfDecks: 1,
                                            preshuffled: false,
                                            refillsWhenEmpty: false,
                                            excludedCardValues: [],
                                            excludedCardSuits: [.club, .diamond, .heart, .joker])
        cardDeck = CardDeck(configuration: config)
    }
    
    func test_numberOfCards() {
        XCTAssertEqual(cardDeck.numberOfCards, 13)
    }
    
    func test_numberOfCards_afterDrawingSomeCards() {
        draw(nTimes: 4, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 9)
    }
    
    func test_numberOfCards_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 0)
    }
    
    func test_numberOfCards_afterShuffle() {
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 13)
        draw(nTimes: 1, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 12)
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 12)
    }
    
    func test_drawCard_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNil(card)
    }
    
    func test_unshuffledOrder() {
        let expected: [Card] = CardValue.unshuffledOrder(for: .spade).map { Card(suit: .spade, value: $0) }
        (0..<cardDeck.numberOfCards).forEach { i in
            let card = cardDeck.drawCard()
            XCTAssertEqual(card, expected[i])
        }
    }
    
    func test_onlySpadesArePresent() {
        (0..<cardDeck.numberOfCards).forEach { _ in
            let card = cardDeck.drawCard()
            XCTAssertEqual(card?.suit, .spade)
            XCTAssertNotEqual(card?.suit, .joker)
            XCTAssertNotEqual(card?.suit, .diamond)
            XCTAssertNotEqual(card?.suit, .club)
            XCTAssertNotEqual(card?.suit, .heart)
        }
    }
}
