//
//  BookSearchTests.swift
//  BookSearchTests
//
//  Created by Bona Deny S on 11/7/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import XCTest
@testable import BookSearch

class BookSearchTests: XCTestCase {

    func testFetchData() {
        let expectation = self.expectation(description: "Fetching")
        
        Network().fetch(keyword: "Science") { (result: Result<Raw, Error>) in
            switch result {
                case .success(let raw) :
                    let books = raw.items
                    for book in books {
                        XCTAssertTrue(type(of: book.volumeInfo.title) == String.self)
                        XCTAssertNotNil(raw)
                    }
                    
                    break
                    
                case .failure(let err) :
                    XCTAssertNotNil(err, "Found error on: \(err)")
                    break
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
