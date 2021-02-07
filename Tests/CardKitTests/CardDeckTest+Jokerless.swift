//
//  CardDeckTest+Jokerless.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

final class CardDeckTest_Jokerless: CardDeckTest {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = CardDeck.Configuration(numberOfDecks: 1,
                                            preshuffled: true,
                                            refillsWhenEmpty: false,
                                            excludedCardValues: [.joker],
                                            excludedCardSuits: [.joker])
        cardDeck = CardDeck(configuration: config)
    }
    
    func test_numberOfCards() {
        XCTAssertEqual(cardDeck.numberOfCards, 52)
    }
    
    func test_numberOfCards_afterDrawingSomeCards() {
        draw(nTimes: 4, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 48)
    }
    
    func test_numberOfCards_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 0)
    }
    
    func test_numberOfCards_afterShuffle() {
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 52)
        draw(nTimes: 1, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 51)
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 51)
    }
    
    func test_drawCard_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNil(card)
    }
    
    func test_noJokersArePresent() {
        (0..<cardDeck.numberOfCards).forEach { _ in
            let card = cardDeck.drawCard()
            XCTAssertNotEqual(card?.value, .joker)
            XCTAssertNotEqual(card?.suit, .joker)
        }
    }
}
