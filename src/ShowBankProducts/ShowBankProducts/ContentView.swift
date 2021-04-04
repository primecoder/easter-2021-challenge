//
//  ContentView.swift
//  ShowBankProducts
//
//  Created by random on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var  cba = CBAService()
    
    var body: some View {
        VStack {
            Text("???")
            ScrollView {
                ForEach(cba.products, id: \.productID) {  product in
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
