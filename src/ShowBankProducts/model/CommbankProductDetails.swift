//
//  CommbankProductDetails.swift
//  ShowBankProducts
//
//  Created by Ace Authors on 5/4/21.
//  

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let commbankProductDetails = try? newJSONDecoder().decode(CommbankProductDetails.self, from: jsonData)

import Foundation

typealias ProductDetails = CommbankProductDetails.DataClass

// MARK: - CommbankProductDetails
struct CommbankProductDetails: Codable {
    let data: DataClass
    let links: Links
    let meta: Meta
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let features: [Feature]
        let eligibility: [Eligibility]
        let fees: [Fee]?
        let depositRates: [DepositRate]?
        let productID: String
        let effectiveFrom, effectiveTo: String?
        let lastUpdated, productCategory, name, dataDescription: String
        let brand, brandName: String
        let applicationURI: String?
        let isTailored: Bool
        let additionalInformation: AdditionalInformation?
        
        enum CodingKeys: String, CodingKey {
            case features, eligibility, fees, depositRates
            case productID = "productId"
            case effectiveFrom, effectiveTo, lastUpdated, productCategory, name
            case dataDescription = "description"
            case brand, brandName
            case applicationURI = "applicationUri"
            case isTailored, additionalInformation
        }
    }
    
    // MARK: - AdditionalInformation
    struct AdditionalInformation: Codable {
        let overviewURI: String?
        let termsURI: String?
        let eligibilityURI, feesAndPricingURI: String?
        
        enum CodingKeys: String, CodingKey {
            case overviewURI = "overviewUri"
            case termsURI = "termsUri"
            case eligibilityURI = "eligibilityUri"
            case feesAndPricingURI = "feesAndPricingUri"
        }
    }
    
    // MARK: - DepositRate
    struct DepositRate: Codable {
        let depositRateType, rate, calculationFrequency, applicationFrequency: String?
        let additionalValue, additionalInfo: String?
    }
    
    // MARK: - Eligibility
    struct Eligibility: Codable {
        let eligibilityType: String
        let additionalValue, additionalInfo: String?
    }
    
    // MARK: - Feature
    struct Feature: Codable {
        let featureType: String
        let additionalValue, additionalInfo: String?
        let additionalInfoURI: String?
        
        enum CodingKeys: String, CodingKey {
            case featureType, additionalValue, additionalInfo
            case additionalInfoURI = "additionalInfoUri"
        }
    }
    
    // MARK: - Fee
    struct Fee: Codable {
        let name, feeType, amount, currency: String?
        let additionalInfo: String?
    }
    
    // MARK: - Links
    struct Links: Codable {
        let linksSelf: String
        
        enum CodingKeys: String, CodingKey {
            case linksSelf = "self"
        }
    }
    
    // MARK: - Meta
    struct Meta: Codable {
    }
}
