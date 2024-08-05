//
//  View+Extenstions.swift
//  ExpenseTracker
//
//  Created by rabie houssaini on 5/8/2024.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center)->some View{
       self .frame(maxWidth: .infinity,alignment: alignment)

    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center)->some View{
       self .frame(maxHeight: .infinity,alignment: alignment)

    }
    
    var safeArea: UIEdgeInsets {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
}
