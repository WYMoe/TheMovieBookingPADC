//
//  CheckoutResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct CheckoutResponse : Codable {

    
    var code : Int?
    var message : String?
    var data : CheckoutVO?


    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data

    }
}
