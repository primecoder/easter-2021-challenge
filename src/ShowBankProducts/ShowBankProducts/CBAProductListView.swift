//
//  ContentView.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 4/4/21.
//

import SwiftUI

struct CBAProductListView: View {
    @ObservedObject var cbaVm = CBAProductListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    ScrollViewReader { value in
                        if (cbaVm.products.count < 1) {
                            Text("Loading ...")
                                .frame(maxWidth: .infinity, maxHeight: 50)
                        }
                        ForEach(Array(cbaVm.products.enumerated()), id: \.offset) { idx, product in
                            CBAProductSummaryView(product: product,
                                                  totalProduct: cbaVm.products.count,
                                                  itemIndex: idx + 1,
                                                  scrollViewProxy: value)
                                .padding(.vertical, 3)
                                .padding(.horizontal)
                                .id(idx)
                                .accessibility(identifier: "ProductSummaryView")
                        }
                    }
                }
                .padding(.top, 12)
                .background(Color(red:0.803, green:0.779, blue:0.779))
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Commonwealth Bank Products")
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct CBAProductSummaryView: View {
    var product: Product
    var totalProduct: Int = 0
    var itemIndex: Int = 0
    var scrollViewProxy: ScrollViewProxy? = nil
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                NavigationLink(destination: CBAProductDetailsView(productId: product.productID)) {
                    HStack {
                        Text(product.name)
                            .font(.title3)
                            .bold()
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color(red: 0.996, green: 0.734, blue: 0.058))
                    .foregroundColor(Color.black)
                    .accessibility(identifier: "ProductLinkNavigation")
                }

                Text(product.productDescription)
                    .lineLimit(4)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
            }
            .cornerRadius(12)
            .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
            
            HStack {
                Text("updated: \(product.lastUpdated)")
                    .font(.custom("Helvetica Neue", fixedSize: 10))
                Text("\(itemIndex)/\(totalProduct)")
                    .font(.footnote)
                    .bold()
                Button("^") { withAnimation(.easeInOut(duration: 1)) { scrollViewProxy?.scrollTo(0) } }
                    .font(.footnote)
                    .padding(0)
            }
            .padding(.horizontal)
            .padding(.vertical, 0)
            .foregroundColor(Color.gray)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
