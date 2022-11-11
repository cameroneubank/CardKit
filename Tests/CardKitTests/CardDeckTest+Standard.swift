//
//  CardDeckTest+Standard.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

final class CardDeckTest_Standard: CardDeckTest {
    override func setUpWithError() throws {
        try super.setUpWithError()
        cardDeck = CardDeck.standard()
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
    }
    
    func test_numberOfCards_afterShuffle() {
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 54)
        draw(nTimes: 1, from: cardDeck)
        XCTAssertEqual(cardDeck.numberOfCards, 53)
        cardDeck.shuffle()
        XCTAssertEqual(cardDeck.numberOfCards, 53)
    }
    
    func test_drawCard_afterDrawingAllCards() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        let card = cardDeck.drawCard()
        XCTAssertNil(card)
    }
    
    func test_drawCard_afterDrawingAllCards_andRefilling() {
        draw(nTimes: cardDeck.numberOfCards, from: cardDeck)
        XCTAssertNil(cardDeck.drawCard())
        cardDeck.delegate = mockDelegate
        cardDeck.refill()
        XCTAssertNotNil(cardDeck.drawCard())
        XCTAssertTrue(mockDelegate.cardDeckDidRefillWasCalled)
    }
    
    func test_unshuffledOrder() {
        expectedUnshuffledCards(numberOfDecks: 1).forEach { expectedCard in
            let nextCard = cardDeck.drawCard()
            XCTAssertEqual(nextCard, expectedCard)
        }
    }
}

// MARK: - Private

extension CardDeckTest_Standard {
    private func expectedUnshuffledCards(numberOfDecks: Int) -> [Card] {
        var cards = [Card]()
        (0..<numberOfDecks).forEach { _ in
            cards.append(contentsOf: CardDeck.ordered)
        }
        return cards
    }
}
