//
//  ViewUtilityFunctions.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 19/05/2023.
//

import Foundation
import SwiftUI

func getGridItems(numberOfColumns:Int, spacing:CGFloat) -> [GridItem]{
    return (1...numberOfColumns).map{
        _ in
        GridItem(.flexible(),spacing:spacing)
    }
}
