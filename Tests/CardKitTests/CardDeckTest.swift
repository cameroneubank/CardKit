//
//  CardDeckTest.swift
//  CardKit
//
//  Created by Cameron Eubank on 3/1/21.
//

@testable import CardKit
import Foundation
import XCTest

open class CardDeckTest: XCTestCase {
    var cardDeck: CardDeck!
}

// MARK: - Helpers

extension CardDeckTest {
    
    func draw(nTimes n: Int, from deck: CardDeck) {
        (0..<n).forEach { _ in
            _ = deck.drawCard()
        }
    }
}
