//
//  CardDeckTest+MultipleDecks.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

final class CardDeckTest_MultipleDecks: CardDeckTest {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = CardDeck.Configuration(numberOfDecks: 2,
                                            preshuffled: false,
                                            refillsWhenEmpty: false,
                                            excludedCardValues: [],
                                            excludedCardSuits: [])
        cardDeck = CardDeck(configuration: config)
    }
    
    func test_numberOfCards() {
        XCTAssertEqual(cardDeck.numberOfCards, 108)
    }
    
    func test_numberOfCards_afterDrawingSomeCards() {
        draw(nTimes: 4, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 104)
    }
    
    func test_numberOfCards_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 0)
    }
    
    func test_numberOfCards_afterShuffle() {
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 108)
        draw(nTimes: 1, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 107)
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 107)
    }
    
    func test_drawCard_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNil(card)
    }
}

