//
//  ContentView.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var  cbaVm = CBAProductListViewModel()
    
    var body: some View {
        VStack {
            Text("???")
            ScrollView {
                ForEach(cbaVm.products, id: \.productID) {  product in
                    Text(product.name)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
