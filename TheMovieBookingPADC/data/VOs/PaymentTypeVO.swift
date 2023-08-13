//
//  PaymentTypeVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 03/08/2023.
//

import Foundation
struct PaymentTypeVO : Codable {
    var id : Int?
    var title : String?
    var icon : String?
    

    enum CodingKeys: CodingKey {
        case id
        case title
        case icon
    }
    
}
