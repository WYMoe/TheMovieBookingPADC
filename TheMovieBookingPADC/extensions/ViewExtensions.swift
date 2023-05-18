//
//  TextLimit.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 06/05/2023.
//

import Foundation
import SwiftUI

extension View {
    func limitText(_ text: Binding<String>, to characterLimit: Int) -> some View {
        self
            .onChange(of: text.wrappedValue) { _ in
                text.wrappedValue = String(text.wrappedValue.prefix(characterLimit))
            }
    }
}

