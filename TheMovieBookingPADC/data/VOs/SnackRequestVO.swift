//
//  SnackRequestVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct SnackRequestVO: Codable {
    var id: Int?
    var quantity: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case quantity
    }
}
