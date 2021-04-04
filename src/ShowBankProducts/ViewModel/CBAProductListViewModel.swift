//
//  CBAProductList.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//  

import Foundation
import Combine

class CBAProductListViewModel: ObservableObject {
    var cba = CBAService()
    @Published var products = [Product]()
    
    private var cancellable: AnyCancellable? = nil
    
    init() {
        // Need to send 'sink' to start the flow.
        cancellable = cba.$products.sink(receiveValue: { (products) in
            self.products = products
        })
    }
}
