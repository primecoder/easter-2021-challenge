//
//  ContentView.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//

import SwiftUI

struct CBAProductListView: View {
    @ObservedObject var  cbaVm = CBAProductListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Commonwealth Bank Products")
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 46)
                .padding(.vertical)
                .background(Color(red: 0.999, green: 0.834, blue: 0.158))
            ScrollView {
                if (cbaVm.products.count < 1) {
                    Text("Loading ...")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                }
                ForEach(Array(cbaVm.products.enumerated()), id: \.offset) { idx, product in
                    CBAProductSummaryView(product: product,
                                          totalProduct: cbaVm.products.count,
                                          itemIndex: idx + 1)
                        .padding(.vertical, 3)
                        .padding(.horizontal)
                }
            }
            .padding(.top, 12)
            .background(Color(red:0.803, green:0.779, blue:0.779))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct CBAProductSummaryView: View {
    var product: Product
    var totalProduct: Int = 0
    var itemIndex: Int = 0
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text(product.name)
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(red: 0.996, green: 0.734, blue: 0.058))
                Text(product.productDescription)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
            }
            .cornerRadius(12)
            .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
            
            Text("\(itemIndex)/\(totalProduct)")
                .font(.footnote)
                .padding(.horizontal)
                .padding(.vertical, 0)
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CBAProductListView()
    }
}
