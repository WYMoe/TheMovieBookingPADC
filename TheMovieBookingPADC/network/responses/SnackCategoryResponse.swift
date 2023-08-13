//
//  SnackCategoryResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 01/08/2023.
//

import Foundation
struct SnackCategoryResponse : Codable, Hashable {

    
    var code : Int?
    var message : String?
    var data : [SnackCategoryVO]?


    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data

    }
}
