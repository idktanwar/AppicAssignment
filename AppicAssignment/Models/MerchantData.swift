//
//  MerchantData.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import Foundation

// MARK: - Welcome
struct MerchantData: Codable {
    let status, message, errorCode: String
    let filterData: [FilterDatum]
}

// MARK: - FilterDatum
struct FilterDatum: Codable {
    let cif, companyName: String
    let accountList, brandList, locationList: [String]
    let hierarchy: [Hierarchy]

    enum CodingKeys: String, CodingKey {
        case cif = "Cif"
        case companyName, accountList, brandList, locationList, hierarchy
    }
}

// MARK: - Hierarchy
struct Hierarchy: Codable {
    let accountNumber: String
    let brandNameList: [BrandNameList]
}

// MARK: - BrandNameList
struct BrandNameList: Codable {
    let brandName: String
    let locationNameList: [LocationNameList]
}

// MARK: - LocationNameList
struct LocationNameList: Codable {
    let locationName: String
    let merchantNumber: [MerchantNumber]
}

// MARK: - MerchantNumber
struct MerchantNumber: Codable {
    let mid: String
    let outletNumber: [String]
}
