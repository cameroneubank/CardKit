//
//  CardDeckTest+RefillsWhenEmpty.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

final class CardDeckTest_RefillsWhenEmpty: CardDeckTest {
    override func setUpWithError() throws {
        try super.setUpWithError()
        let config = CardDeck.Configuration(numberOfDecks: 1,
                                            shuffled: true,
                                            refillsWhenEmpty: true,
                                            excludedCardValues: [],
                                            excludedCardSuits: [])
        cardDeck = CardDeck(configuration: config)
    }
    
    func test_numberOfCards() {
        XCTAssertEqual(cardDeck.numberOfCards, 54)
    }
    
    func test_numberOfCards_afterDrawingSomeCards() {
        draw(nTimes: 4, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 50)
    }
    
    func test_numberOfCards_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 0)
        cardDeck.delegate = mockDelegate
        XCTAssertNotNil(cardDeck.drawCard())
        XCTAssertTrue(mockDelegate.cardDeckDidRefillWasCalled)
    }
    
    func test_numberOfCards_afterShuffle() {
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 54)
        draw(nTimes: 1, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 53)
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 53)
    }
    
    func test_numberOfCards_beforeAndAfterDrawingAllCards_andBeforeAndAfterShuffling() {
        XCTAssertEqual(cardDeck.numberOfCards, 54)
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNotNil(card) // This should never be nil.
        XCTAssertEqual(cardDeck.numberOfCards, 53) // Since one has already been drawn.
    }
    
    func test_drawCard_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNotNil(card) // This should never be nil.
    }
}
