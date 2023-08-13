//
//  SnackResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 01/08/2023.
//

import Foundation
struct SnackResponse : Codable, Hashable {

    
    var code : Int?
    var message : String?
    var data : [SnackVO]?


    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data

    }
}
