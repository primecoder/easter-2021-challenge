//
//  ShowBankProductsUITests.swift
//  ShowBankProductsUITests
//
//  Created by Ace Authors on 5/4/21.
//  

import XCTest

class ShowBankProductsUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testProductListingPage() throws {
        // UI tests must launch the application that they test.
        app.launch()

        XCTAssertTrue(app.staticTexts["Commonwealth Bank Products"].exists)
        XCTAssertGreaterThan(app.buttons.matching(identifier: "ProductSummaryView").count, 0)
    }
    
    func testProductDetailsPage() throws {
        // UI tests must launch the application that they test.
        app.launch()

        let buttons = app.buttons.matching(identifier: "ProductSummaryView")
        XCTAssertTrue(app.staticTexts["Commonwealth Bank Products"].exists)
        XCTAssertGreaterThan(buttons.count, 0)
        
        buttons.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Product Details"].exists)
        XCTAssertTrue(app.buttons["Eligibility"].exists)
        XCTAssertTrue(app.buttons["Features"].exists)
        XCTAssertTrue(app.buttons["Fees"].exists)
        XCTAssertTrue(app.buttons["Rates"].exists)
        XCTAssertTrue(app.buttons["Commonwealth Bank Products"].exists)
        
        app.buttons["Features"].tap()
        XCTAssertTrue(app.staticTexts["Features:"].exists)
        
        app.buttons["Fees"].tap()
        XCTAssertTrue(app.staticTexts["Fees:"].exists)
        
        app.buttons["Rates"].tap()
        XCTAssertTrue(app.staticTexts["Deposit Rates:"].exists)
        
        app.buttons["Commonwealth Bank Products"].tap()
        XCTAssertTrue(app.staticTexts["Commonwealth Bank Products"].exists)
        
        print("Done")
    }

}
