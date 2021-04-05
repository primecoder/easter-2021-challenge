//
//  ShowBankProductsTests.swift
//  ShowBankProductsTests
//
//  Created by Ace Authors on 5/4/21.
//  

import Foundation
import Combine
import XCTest

@testable import ShowBankProducts

class ShowBankProductsTests: XCTestCase {
    
    let existProdId = "ad22b1f0967349e8a5d586afe7f0d845"
    let nonExistProdId = "123xxxx"
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testProductDetailsServiceNotFound() throws {
        let cbaService = CBAProductDetailsService(on: DispatchQueue.global(),
                                                  productId: nonExistProdId)
        let cancellable = cbaService.$productDetails
            .receive(on: DispatchQueue.global())
            .sink { result in
            } receiveValue: { (prodDetails) in
            }
        wait(for: [], timeout: 5)
        cancellable.cancel()
        
        XCTAssertNotNil(cancellable)
        XCTAssertNil(cbaService.productDetails)
    }

    func testProductDetailsServiceFound() throws {
        let cbaService = CBAProductDetailsService(on: DispatchQueue.global(),
                                                  productId: existProdId)
        let exp = expectation(description: "\(#function)\(#line)")
        let cancellable = cbaService.$productDetails
            .receive(on: DispatchQueue.global())
            .sink { result in
                exp.fulfill()
            } receiveValue: { (prodDetails) in
                if let _ = prodDetails {
                    exp.fulfill()
                }
            }
        waitForExpectations(timeout: 5, handler: nil)
        cancellable.cancel()
        
        XCTAssertNotNil(cancellable)
        XCTAssertNotNil(cbaService.productDetails)
        XCTAssertGreaterThan(cbaService.productDetails!.features.count, 0)
    }
    
    func testProductListService() throws {
        let cbaService = CBAProductListService(on: DispatchQueue.global())
        sleep(5)
        XCTAssertGreaterThan(cbaService.products.count, 0)
    }
    
    func testProductListAPIEndPoint() throws {
        let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products"
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("2", forHTTPHeaderField: "x-v")
        
        let exp = expectation(description: "\(#function)\(#line)")
        let cancellable = URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: CommbankProduct.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global())
            .sink { result in
                switch result {
                case .finished:
                    exp.fulfill()
                default:
                    break
                }
            } receiveValue: { (values) in
                for p in values.data.products {
                    print("UNIT TEST >>> product: \(p.productID), \(p.name)")
                    XCTAssertNotEqual(p.productID, "")
                    XCTAssertNotEqual(p.name, "")
                }
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(cancellable)
        cancellable.cancel()
    }
    
    func testProductDetailsAPIEndPoint() throws {
        let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products/ad22b1f0967349e8a5d586afe7f0d845"
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("2", forHTTPHeaderField: "x-v")
        
        let exp = expectation(description: "\(#function)\(#line)")
        let cancellable = URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: CommbankProductDetails.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.global())
            .sink { result in
                switch result {
                case .finished:
                    exp.fulfill()
                default:
                    break
                }
            } receiveValue: { (values) in
                XCTAssertNotNil(values)
                XCTAssertGreaterThan(values.data.features.count, 0)
            }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(cancellable)
        cancellable.cancel()
    }
    
}
