//
//  UserObject.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 30/07/2023.
//

import Foundation
import RealmSwift

class UserObject : Object {
    @Persisted(primaryKey: true) dynamic var id : Int?
    @Persisted dynamic var message : String?
    @Persisted dynamic var email : String?
    @Persisted dynamic var phone : String?
    @Persisted dynamic var totalExpense : Int?
    @Persisted dynamic var profileImage : String?
    @Persisted dynamic var token : String?
    
    func toUserVO()-> UserVO {
        return UserVO(id: id,message: message,email: email,phone: phone,totalExpense: totalExpense,profileImage: profileImage,token: token)
    }
}
