//
//  main.swift
//  CommbankProbe
//
//  Created by random on 4/4/21.
//

import Foundation

let urlString = "https://api.commbank.com.au/public/cds-au/v1/banking/products"
let url = URL(string: urlString)!
var urlRequest = URLRequest(url: url)

urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
urlRequest.setValue("2", forHTTPHeaderField: "x-v")

// Simplest form of URLSession.
let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
    if let resp = response { print("Response> \(resp)") }
    let commbankProduct = try? JSONDecoder().decode(CommbankProduct.self, from: data!)
    print("Data >>> \n\(commbankProduct)")
}
task.resume()

print("Waiting for server to response ...")
sleep(5)
print("Done")
