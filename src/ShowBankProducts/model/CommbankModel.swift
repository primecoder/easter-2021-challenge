// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let commbankProduct = try? newJSONDecoder().decode(CommbankProduct.self, from: jsonData)

import Foundation

// MARK: - CommbankProduct
struct CommbankProduct: Codable {
    let data: DataClass
    let links: Links
    let meta: Meta
}

// MARK: - DataClass
struct DataClass: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let productID: String
    let effectiveFrom, effectiveTo: String
    let lastUpdated, productCategory, name, productDescription: String
    let brand, brandName: String
    let applicationURI: String? = nil
    let isTailored: Bool
    let additionalInformation: AdditionalInformation? = nil

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
        case effectiveFrom, effectiveTo, lastUpdated, productCategory, name
        case productDescription = "description"
        case brand, brandName
        case applicationURI = "applicationUri"
        case isTailored, additionalInformation
    }
}

// MARK: - AdditionalInformation
struct AdditionalInformation: Codable {
    let overviewURI: String
    let termsURI: String
    let eligibilityURI: String
    let feesAndPricingURI: String

    enum CodingKeys: String, CodingKey {
        case overviewURI = "overviewUri"
        case termsURI = "termsUri"
        case eligibilityURI = "eligibilityUri"
        case feesAndPricingURI = "feesAndPricingUri"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf, first, next, last: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case first, next, last
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalRecords, totalPages: Int
}
