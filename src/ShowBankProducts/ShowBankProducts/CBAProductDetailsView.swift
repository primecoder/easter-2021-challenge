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
        Group  {
            Text(cbaVm.productDetails?.name ?? "...")
                .bold()
                .font(.title)
                .lineLimit(3)
                .background(Color(red: 0.996, green: 0.734, blue: 0.058))
            
            ScrollView {
                if let prodDetails = cbaVm.productDetails {
                    ProductDetailsView(productDetails: prodDetails)
                        .padding()
                }
            }
            .background(Color.white)
        }
        .padding(.top, 32)
        .background(Color(red: 0.996, green: 0.734, blue: 0.058))
        .cornerRadius(12)
        .padding()
        .shadow(color: .gray, radius: 5, x: 0.0, y: 0.0)
        .background(Color(red:0.803, green:0.779, blue:0.779))
        .edgesIgnoringSafeArea(.bottom)
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
                Text("Features").tag(1)
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
            case 2:
                VStack(alignment: .leading) {
                    Text("Fees:")
                        .bold()
                    if let fees = productDetails.fees {
                        ForEach(Array(fees.enumerated()), id: \.offset) { idx, fee in
                            ProductFeeView(fee: fee)
                        }
                    }
                }
            case 3:
                VStack(alignment: .leading) {
                    Text("Deposit Rates:")
                        .bold()
                    if let rates = productDetails.depositRates {
                        ForEach(Array(rates.enumerated()), id: \.offset) { idx, rate in
                            ProductRateView(rate: rate)
                                .padding(.horizontal)
                        }
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

struct ProductRateView: View {
    var rate: CommbankProductDetails.DepositRate
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(rate.depositRateType ?? "?")
                VStack(alignment: .trailing) {
                    HStack { Text("Calculate freq:"); Text(rate.calculationFrequency ?? "-") }
                    HStack { Text("Application freq:"); Text(rate.applicationFrequency ?? "-") }
                    HStack { Text("Additional value:"); Text(rate.additionalValue ?? "-") }
                }
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 32)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text(rate.rate ?? "--.-")

        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.bottom)
    }
}

struct ProductFeeView: View {
    var fee: CommbankProductDetails.Fee
    var body: some View {
        if let amount = fee.amount {
            HStack {
                Text(fee.name ?? "(n/a)")
                    .lineLimit(2)
                Spacer()
                HStack {
                    Text("$\(amount)")
                    Text("AUD").font(.footnote)
                }
            }
            .padding(.leading)
            .frame(height: 50)
        }
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
