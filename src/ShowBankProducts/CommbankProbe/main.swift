//
//  main.swift
//  CommbankProbe
//
//  Created by random on 4/4/21.
//

import Foundation

//import Combine
//
//let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products"
//let url = URL(string: urlString)!
//var urlRequest = URLRequest(url: url)
//
//urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
//urlRequest.setValue("2", forHTTPHeaderField: "x-v")
//
//let x = URLSession.shared
//    .dataTaskPublisher(for: urlRequest)
//    .map { $0.data }
//    .decode(type: CommbankProduct.self, decoder: JSONDecoder())
//    .sink { result in
//        print("RESULT: \(result)")
//    } receiveValue: { (values) in
//        for p in values.data.products {
//            print(">>> product: \(p.productID), \(p.name)")
//        }
//    }

let cbaService = CBAService()
let cancellable = cbaService.$products

print("Waiting for data from remote service ...")
sleep(5)
var itemCount = 0
for p in cbaService.products {
    itemCount += 1
    print(">>>>>>>> \(itemCount):\(p)")
}
