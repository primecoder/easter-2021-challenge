//
//  CBAProductList.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//  

import Foundation
import Combine

/// Provide View Model for listing CBA products.
class CBAProductListViewModel: ObservableObject {
    var cba = CBAProductListService()
    @Published var products = [Product]()
    
    private var cancellable: AnyCancellable? = nil
    
    init() {
        // Need to send 'sink' to start the flow.
        cancellable = cba.$products.sink(receiveValue: { (products) in
            self.products = products.sorted(by: { $0.name < $1.name })  // Sorted by name
        })
    }
}
