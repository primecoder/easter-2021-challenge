//
//  CBAProductDetailsService.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 5/4/21.
//  

import Foundation
import Combine

/// Provide accesses to Commonwealth Bank's public APIs for retrieving list of products.
class CBAProductDetailsService: ObservableObject {
    let getProductsEndpoint: String = "https://api.commbank.com.au/public/cds-au/v1/banking/products/"
    
    /// List  of available products from CBA.
    @Published var productDetails: ProductDetails? = nil
    
    /// Store a cancellable-publisher for fetching products.
    private var fetchCancellable: AnyCancellable? = nil
    
    var productId: String
    
    var opQueue: DispatchQueue
    
    init(on queue: DispatchQueue = DispatchQueue.main,
         productId: String = "ad22b1f0967349e8a5d586afe7f0d845") {
        self.opQueue = queue
        self.productId = productId
        refetchData()
    }
    
    /// (Re)fetch products from remote server and cache the product list locally.
    func refetchData() {
        let urlString = "\(getProductsEndpoint)\(productId)"
        guard let url = URL(string: urlString) else {
            print("ERROR> CBAService.refetchProducts: failed to create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("2", forHTTPHeaderField: "x-v")

        fetchCancellable = URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .receive(on: opQueue)
            .decode(type: CommbankProductDetails.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    print("Done fetching product details: \(result)")
                    self.fetchCancellable?.cancel()
                default:
                    break
                }
            } receiveValue: { (values) in
                self.productDetails = values.data
            }
    }
    
}
