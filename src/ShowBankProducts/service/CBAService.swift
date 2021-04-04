//
//  CBAService.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//  

import Foundation
import Combine

/// Provide accesses to Commonwealth Bank's public APIs and services.
class CBAService: ObservableObject {
    let getProductsEndpoint: String = "https://api.commbank.com.au/public/cds-au/v1/banking/products?page-size=500"
    
    /// List  of available products from CBA.
    @Published var products: [Product] = []
    
    /// Store a cancellable-publisher for fetching products.
    private var fetchProductsCancellable: AnyCancellable? = nil
    
    init() {
        refetchProducts()
    }
    
    /// (Re)fetch products from remote server and cache the product list locally.
    func refetchProducts() {
        guard let url = URL(string: getProductsEndpoint) else {
            print("ERROR> CBAService.refetchProducts: failed to create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("2", forHTTPHeaderField: "x-v")

        fetchProductsCancellable = URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .receive(on: DispatchQueue.main)
            .decode(type: CommbankProduct.self, decoder: JSONDecoder())
            .sink { result in
                print("Done fetching products: \(result)")
            } receiveValue: { (values) in
                for p in values.data.products {
                    self.products.append(p)
                }
            }
    }
    
}
