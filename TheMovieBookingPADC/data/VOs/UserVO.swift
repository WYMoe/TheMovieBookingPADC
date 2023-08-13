//
//  UserVO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 27/07/2023.
//

import Foundation
import RealmSwift


struct UserVO : Codable, Hashable{
    
 var id : Int?
 var message : String?
 var email : String?
 var phone : String?
 var totalExpense : Int?
 var profileImage : String?
 var token : String?
    
    enum CodingKeys : String, CodingKey {
        case id
        case message
        case email
        case phone = "known_for"
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
    }
    
    
}
