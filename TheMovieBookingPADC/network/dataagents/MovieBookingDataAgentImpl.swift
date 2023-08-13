//
//  MovieBookingDataAgentImpl.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 27/07/2023.
//

import Foundation
import Alamofire
import RealmSwift

class MovieBookingDataAgentImpl : MovieBookingDataAgent {
   
    
    
    
  
    
   
    static let shared = MovieBookingDataAgentImpl()
    
    private init(){
        
    }
    
    
    //get otp
    func getOTP(phoneNumber: String, onSuccess: @escaping (OTPVO) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let parameters: Parameters = [
            "phone": "\(phoneNumber)",
           
        ]

        
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_OTP, method: .post,parameters: parameters) { (otpvo: OTPVO) in
            onSuccess(otpvo)
            
        } onError: { error in
            print(error)
            onFailure(error)
            
        }
    }
    
    
    // sign in and get user info
    
    func signInAndGetUserInfo(phoneNumber: String, otp: String, onSuccess: @escaping (UserResponse) -> Void, onFailure: @escaping (Error) -> Void) {
        let parameters: Parameters = [
            "phone": "\(phoneNumber)",
            "otp" : "\(otp)"
           
        ]
        
        
        fetchDataWithParameters(forEndPoint: ENDPOINT_CHECK_OTP, method: .post, parameters: parameters) { (userResponse : UserResponse) in
            
            onSuccess(userResponse )
           
            
        } onError: { error in
            onFailure(error)
            
        }

    }
    
    //get cities
    
    func getCities(onSuccess: @escaping ([CityVO]) -> Void, onFailure: @escaping (Error) -> Void) {
                
        fetchDataWithParameters(forEndPoint: ENDPOINT_GET_CITIES, method: .get, parameters: Parameters()) { (citiesResponse : CitiesResponse) in
        
            onSuccess(citiesResponse.data ?? [])
        } onError: { error in
            onFailure(error)
        }

    }
    
    //set city
    
    func setCity(token: String,cityId:Int,onSuccess: @escaping (SetCityVO) -> Void, onFailure: @escaping (Error) -> Void){
        let parameters: Parameters = [
            "city_id" : cityId
        ]
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        
        AF.request("\(BASE_URL)\(ENDPOINT_SET_CITIES)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: SetCityVO.self) { response in
             switch response.result {
             case .success(let value):
                 onSuccess(value)
             case .failure(let error):
                 onFailure(error)
             }
         }
    }
    
    //get banners
    func getBanner(onSuccess: @escaping ([BannerVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        AF.request("\(BASE_URL)\(ENDPOINT_GET_BANNERS)", method: .get,encoding: JSONEncoding.default)
            .responseDecodable(of:BannerResponse.self) { response in
                switch response.result {
                case .success(let bannerResponse):
                    onSuccess(bannerResponse.data ?? [BannerVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get movie current
    
    func getMoviesCurrent(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        AF.request("\(BASE_URL)\(ENDPOINT_GET_MOVIES_CURRENT)", method: .get,encoding: JSONEncoding.default)
            .responseDecodable(of:MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    onSuccess(movieResponse.data ?? [MovieVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get movie comingsoon
    func getMoviesComingSoon(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        AF.request("\(BASE_URL)\(ENDPOINT_GET_MOVIES_COMINGSOON)", method: .get,encoding: JSONEncoding.default)
            .responseDecodable(of:MovieResponse.self) { response in
                switch response.result {
                case .success(let movieResponse):
                    onSuccess(movieResponse.data ?? [MovieVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }

    }
    
    //get movie detail
    func getMovieDetail(movieId: Int, onSuccess: @escaping (MovieDetailVO) -> Void, onFailure: @escaping (Error) -> Void) {
        AF.request("\(BASE_URL)\(ENDPOINT_GET_MOVIE_DETAIL)\(movieId)", method: .get,encoding: JSONEncoding.default)
            .responseDecodable(of:MovieDetailResponse.self) { response in
                switch response.result {
                case .success(let movieDetailResponse):
                    onSuccess(movieDetailResponse.data ?? MovieDetailVO())
                case .failure(let error):
                    onFailure(error)
                }
            }

    }
    
    //get cinema and showtime
    func getCinemaAndShowtime(token: String, date:String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_CINEMA_AND_SHOWTIME)\(date)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:CinemaAndShowtimeResponse.self) { response in
               
                switch response.result {
                   
                case .success(let cinemaAndShowtimeResponse):
                    onSuccess(cinemaAndShowtimeResponse.data ?? [CinemaVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get seating plan
    func getSeatingPlanByShowtime(token: String,timeslotId: Int, date: String, onSuccess: @escaping ([[MovieSeatVO]]) -> Void, onFailure: @escaping (Error) -> Void) {
        
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_SEATING_PLAN)\(timeslotId)\(ENDPOINT_SHOWTIME_PARAM)\(date)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:SeatingPlanResponse.self) { response in
              
                switch response.result {
                   
                case .success(let seatingPlanResponse):
                    onSuccess(seatingPlanResponse.data ?? [[MovieSeatVO]]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get snack category
    
    func getSnackCategory(token: String, onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_SNACK_CATEGORY)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:SnackCategoryResponse.self) { response in
               
                switch response.result {
                   
                case .success(let snackCategoryResponse):
                    onSuccess(snackCategoryResponse.data ?? [SnackCategoryVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    // get snacks
    
    func getSnacks(token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_SNACKS)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:SnackResponse.self) { response in
               
                switch response.result {
                   
                case .success(let snackResponse):
                    onSuccess(snackResponse.data ?? [SnackVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get snacks by category
    func getSnacksByCategory(categoryId: Int, token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_SNACKS_BY_CATEGORY)\(categoryId)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:SnackResponse.self) { response in
               
                switch response.result {
                   
                case .success(let snackResponse):
                    onSuccess(snackResponse.data ?? [SnackVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    //get payment types
    func getPaymentTypes(token: String, onSuccess: @escaping ([PaymentTypeVO]) -> Void, onFailure: @escaping (Error) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        AF.request("\(BASE_URL)\(ENDPOINT_GET_PAYMENT_TYPES)", method: .get,encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of:PaymentTypeResponse.self) { response in
               
                switch response.result {
                   
                case .success(let paymentTypeResponse):
                    onSuccess(paymentTypeResponse.data ?? [PaymentTypeVO]())
                case .failure(let error):
                    onFailure(error)
                }
            }
    }
    
    
    //checkout
    func checkout(token: String, timeslotId: Int, seatName: String, date: String, movieId: Int, paymentId: Int, snacks: [SnackRequestVO], onSuccess: @escaping (CheckoutVO) -> Void, onFailure: @escaping (Error) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        let checkOutRequest = CheckOutRequestVO(
            cinema_day_timeslot_id: timeslotId,
            seat_number: seatName,
            booking_date: date,
            movie_id: movieId,
            payment_type_id: paymentId,
            snacks: snacks

        )
         
        do {
            let jsonData = try JSONEncoder().encode(checkOutRequest)
            if let parameters = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                
         
                AF.request("\(BASE_URL)\(ENDPOINT_CHECKOUT)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CheckoutResponse.self) { response in
                    switch response.result {
                    case .success(let checkoutResponse):
                        onSuccess(checkoutResponse.data ?? CheckoutVO())
                    case .failure(let error):
                        onFailure(error)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
}
