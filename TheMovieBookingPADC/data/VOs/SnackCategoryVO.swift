//
//  SnackCategoryVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 01/08/2023.
//

import Foundation
struct SnackCategoryVO : Codable, Hashable {
    

    var id : Int?
    var title : String?
    var titleMM : String?
    var isActive : Int?
    var createdAt : String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case titleMM = "title_mm"
        case isActive = "is_active"
        case createdAt = "created_at"

    }
    
    
}
