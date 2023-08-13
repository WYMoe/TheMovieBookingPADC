//
//  UserResponse.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation
struct UserResponse : Codable {
    var code : Int?
    var message : String?
    var data : UserVO?
    var token : String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        case token
    }
}
