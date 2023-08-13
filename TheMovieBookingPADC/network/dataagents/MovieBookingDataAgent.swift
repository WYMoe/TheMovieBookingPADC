//
//  MovieBookingDataAgent.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 27/07/2023.
//

import Foundation
import Alamofire

protocol MovieBookingDataAgent {
    
    func getOTP(phoneNumber : String, onSuccess : @escaping(OTPVO) -> Void, onFailure: @escaping (Error) -> Void)
    func signInAndGetUserInfo(phoneNumber : String, otp : String, onSuccess : @escaping(UserResponse) -> Void, onFailure: @escaping (Error) -> Void)
    func getCities(onSuccess: @escaping ([CityVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func setCity(token: String,cityId:Int,onSuccess: @escaping (SetCityVO) -> Void, onFailure: @escaping (Error) -> Void)
    func getBanner(onSuccess: @escaping ([BannerVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getMoviesCurrent(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getMoviesComingSoon(onSuccess: @escaping ([MovieVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getMovieDetail(movieId : Int,onSuccess: @escaping (MovieDetailVO) -> Void, onFailure: @escaping (Error) -> Void)
    func getCinemaAndShowtime(token: String, date : String, onSuccess: @escaping ([CinemaVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getSeatingPlanByShowtime(token: String,timeslotId: Int, date : String, onSuccess: @escaping ([[MovieSeatVO]]) -> Void, onFailure: @escaping (Error) -> Void)
    func getSnackCategory(token: String, onSuccess: @escaping ([SnackCategoryVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getSnacks(token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func getSnacksByCategory(categoryId: Int, token: String, onSuccess: @escaping ([SnackVO]) -> Void, onFailure: @escaping (Error) -> Void)

    func  getPaymentTypes (token: String, onSuccess: @escaping ([PaymentTypeVO]) -> Void, onFailure: @escaping (Error) -> Void)
    func checkout (token: String,timeslotId : Int,seatName: String, date:String, movieId:Int,paymentId:Int,snacks:[SnackRequestVO], onSuccess: @escaping (CheckoutVO) -> Void, onFailure: @escaping (Error) -> Void)
    
}
