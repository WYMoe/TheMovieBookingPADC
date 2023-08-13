//
//  PaymentTypeResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct PaymentTypeResponse : Codable {

    
    var code : Int?
    var message : String?
    var data : [PaymentTypeVO]?


    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data

    }
}
