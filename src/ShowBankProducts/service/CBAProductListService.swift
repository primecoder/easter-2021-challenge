//
//  CBAService.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//  

import Foundation
import Combine

/// Provide accesses to Commonwealth Bank's public APIs for retrieving list of products.
class CBAProductListService: ObservableObject {
    let getProductsEndpoint: String = CBAServices.apiEndPointProductList

    /// List  of available products from CBA.
    @Published var products: [Product] = []
    
    /// Store a cancellable-publisher for fetching products.
    private var fetchCancellable: AnyCancellable? = nil
    
    var opQueue: DispatchQueue
    
    init(on queue: DispatchQueue = DispatchQueue.main) {
        opQueue = queue
        refetchData()
    }
    
    /// (Re)fetch products from remote server and cache the product list locally.
    func refetchData() {
        guard let url = URL(string: getProductsEndpoint) else {
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
            .decode(type: CommbankProduct.self, decoder: JSONDecoder())
            .sink { result in
                switch result {
                case .finished:
                    print("Done fetching products: \(result)")
                    self.fetchCancellable?.cancel()
                default:
                    break
                }
            } receiveValue: { (values) in
                for p in values.data.products {
                    self.products.append(p)
                }
            }
    }
    
}
