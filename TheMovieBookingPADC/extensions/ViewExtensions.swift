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
    
    func popupNavigationView<Content: View> (horizontalPadding:CGFloat = 40, show:Binding<Bool>, @ViewBuilder content: @escaping ()->Content)->some View{
        
        return self
            .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
            .overlay{
            if show.wrappedValue {
                GeometryReader{
                    proxy in
                    
                    Color.primary
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    let size = proxy.size
                    
                    NavigationView{
                        content()
                    }
                    .frame(width: size.width - horizontalPadding, height: size.height / 1.5, alignment:.center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity,maxHeight:.infinity,alignment:.center)
                    
                }
            }
        }
    }
}

