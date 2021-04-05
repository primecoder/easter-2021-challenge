//
//  CBAProductDetailsView.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 5/4/21.
//  

import SwiftUI

struct CBAProductDetailsView: View {
    var productId: String
    @ObservedObject var cbaVm: CBAProductDetailsService
    
    init(productId: String) {
        self.productId = productId
        cbaVm = CBAProductDetailsService(productId: productId)
    }

    var body: some View {
        Text(cbaVm.productDetails?.name ?? "...")
            .bold()
            .font(.title)
            .lineLimit(3)
        
        ScrollView {
            if let prodDetails = cbaVm.productDetails {
                ProductDetailsView(productDetails: prodDetails)
                    .padding()
            }
        }
    }
}

struct ProductDetailsView: View {
    var productDetails: ProductDetails
    
    @State private var selectedSection: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Description:")
                    .bold()
                Text(productDetails.dataDescription)
                    .padding(.leading)
                    .padding(.bottom)
            }
            
            Picker("", selection: $selectedSection) {
                Text("Eligibility").tag(0)
                Text("Fatures").tag(1)
                Text("Fees").tag(2)
                Text("Rates").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.bottom)

            switch (selectedSection) {
            case 0:
                VStack(alignment: .leading) {
                    Text("Eligibility:")
                        .bold()
                    ForEach(Array(productDetails.eligibility.enumerated()), id: \.offset) { idx, item in
                        ProductEligibilityView(eligibility: item)
                    }
                }
            case 1:
                VStack(alignment: .leading, spacing: 0) {
                    Text("Features:")
                        .bold()
                    ForEach(Array(productDetails.features.enumerated()), id: \.offset) { idx, feature in
                        ProductDetailsFeatureView(productFeature: feature)
                    }
                }
            default:
                Text("Unsupported selection")
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Product Details")
    }
}

struct ProductEligibilityView: View {
    var eligibility: CommbankProductDetails.Eligibility
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "checkmark.circle")
                Group {
                    Text(eligibility.eligibilityType)
                    Text(eligibility.additionalValue ?? "")
                }
            }

            if let additionalInfo = eligibility.additionalInfo {
                HStack {
                    Image(systemName: "checkmark.circle")
                        .opacity(0.0)
                    Text(additionalInfo)
                        .font(.body)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
}

struct ProductDetailsFeatureView: View {
    var productFeature: CommbankProductDetails.Feature
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "checkmark.circle")
            if let additionalInfo = productFeature.additionalInfo {
                Text(additionalInfo)
            } else {
                HStack {
                    Text(productFeature.featureType)
                }
            }
        }
        .padding(.bottom)
    }
}
