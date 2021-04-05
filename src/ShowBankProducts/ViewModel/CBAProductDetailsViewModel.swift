//
//  CBAProductDetailsViewModel.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 5/4/21.
//  

import Foundation
import Combine

/// Provide View Model for CBA product details.
class CBAProductDetailsViewModel: ObservableObject {
    var productId: String
    var cba: CBAProductDetailsService
    
    @Published var productDetails: ProductDetails? = nil
    
    private var cancellable: AnyCancellable? = nil
    
    init(productId: String) {
        self.productId = productId
        cba = CBAProductDetailsService(productId: productId)
        
        // Need to send 'sink' to start the flow.
        cancellable = cba.$productDetails.sink(receiveValue: { (productDetails) in
            self.productDetails = productDetails
        })
    }
}
