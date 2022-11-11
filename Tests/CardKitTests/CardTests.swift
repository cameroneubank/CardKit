//
//  CardTests.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

import XCTest
@testable import CardKit

final class CardTests: XCTestCase {
    func test_card_equality_sameSuit_sameValue() {
        let c1 = Card(suit: .spade, value: .ace)
        let c2 = Card(suit: .spade, value: .ace)
        XCTAssertEqual(c1.suit, c2.suit)
        XCTAssertEqual(c1.value, c2.value)
    }
    
    func test_card_equality_sameSuit_differentValue() {
        let c1 = Card(suit: .spade, value: .ace)
        let c2 = Card(suit: .spade, value: .king)
        XCTAssertEqual(c1.suit, c2.suit)
        XCTAssertNotEqual(c1.value, c2.value)
    }
    
    func test_card_equality_differentSuit_sameValue() {
        let c1 = Card(suit: .spade, value: .ace)
        let c2 = Card(suit: .club, value: .ace)
        XCTAssertNotEqual(c1.suit, c2.suit)
        XCTAssertEqual(c1.value, c2.value)
    }
    
    func test_card_equality_differentSuit_differentValue() {
        let c1 = Card(suit: .spade, value: .ace)
        let c2 = Card(suit: .club, value: .king)
        XCTAssertNotEqual(c1.suit, c2.suit)
        XCTAssertNotEqual(c1.value, c2.value)
    }
}
