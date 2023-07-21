//
//  BaseView.swift
//  ClassifyIt
//
//  Created by Ahmad Qureshi on 21/07/23.
//

import SwiftUI

struct BaseView<Content>: View where Content: View {
    
    @ViewBuilder
    var content: (() -> Content)
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.ignoresSafeArea()
            content()
        }
    }
}
