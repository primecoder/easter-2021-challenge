//
//  main.swift
//  CommbankProbe
//
//  Created by random on 4/4/21.
//

import Foundation
import Combine

func probeProductEndpoint() -> Cancellable {
    let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products"
    let url = URL(string: urlString)!
    var urlRequest = URLRequest(url: url)
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("2", forHTTPHeaderField: "x-v")
    
    return URLSession.shared
        .dataTaskPublisher(for: urlRequest)
        .map { $0.data }
        .decode(type: CommbankProduct.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.global())
        .sink { result in
            print("RESULT: \(result)")
        } receiveValue: { (values) in
            for p in values.data.products {
                print(">>> product: \(p.productID), \(p.name)")
            }
        }
}

func probeProductDetailsEndpoint() -> Cancellable {
    let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products/ad22b1f0967349e8a5d586afe7f0d845"
    let url = URL(string: urlString)!
    var urlRequest = URLRequest(url: url)
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    urlRequest.setValue("2", forHTTPHeaderField: "x-v")
    
    return URLSession.shared
        .dataTaskPublisher(for: urlRequest)
        .map { $0.data }
        .decode(type: CommbankProductDetails.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.global())
        .sink { result in
            print("RESULT: \(result)")
        } receiveValue: { (values) in
            print("Values: \(values)")
        }
}

// TODO: move this to unit test
//let opQueue = DispatchQueue.global()
//let cbaService = CBAProductListService(on: opQueue)
//var itemCount = 0
//let cancellable = cbaService.$products
//    .receive(on: opQueue)
//    .sink { result in
//       print("RESULT: \(result)")
//    } receiveValue: { (products) in
//        for p in products {
//            itemCount += 1
//            print(">>>>>>>> \(itemCount):\(p.productID), \(p.name)")
//        }
//    }

// TODO: move this to unit test
let opQueue = DispatchQueue.global()
//let cbaService = CBAProductDetailsService(on: opQueue, productId: "5b47845a7f0044e58db616bb734e8350")
let cbaService = CBAProductDetailsService(on: opQueue, productId: "ad22b1f0967349e8a5d586afe7f0d845")
var itemCount = 0
let cancellable = cbaService.$productDetails
    .receive(on: opQueue)
    .sink { result in
       print("RESULT: \(result)")
    } receiveValue: { (prodDetails) in
        print("RECEIVE: \(prodDetails)")
    }

//let cancellableProductListService = probeProductEndpoint()
//let cancellableProductDetailsService = probeProductDetailsEndpoint()

print("Waiting for results...")
sleep(5)
