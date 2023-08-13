//
//  UserDAO.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 28/07/2023.
//

import Foundation
import RealmSwift

class UserDAO {
    //singleton
    
    static let shared = UserDAO()
    
    private init(){
        
    }
    
    //save user
    
    func saveUserInfo(userInfo : UserObject){
        do {
            let realm = try Realm()
            
            
            try realm.write({
                realm.add(userInfo,update: .all)
            })
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    
    //get user
    func getUserInfo() -> UserVO?{
        do{
            let realm = try Realm()
            
           return realm.objects(UserObject.self).map { userobj in
                userobj.toUserVO()
            }.first
           // return realm.object(ofType: UserObject.self, forPrimaryKey: id)?.toUserVO()
        }catch {
            let error = error as NSError
            fatalError("Unresolved error : \(error) \(error.userInfo)")
        }
    }
    
    // check user
    
    
    func checkUser() -> UserVO? {
        let realm = try! Realm()
        // Access all dogs in the realm
        let users = realm.objects(UserObject.self)
        print(users)
        return users.first?.toUserVO()
    }
    
}
