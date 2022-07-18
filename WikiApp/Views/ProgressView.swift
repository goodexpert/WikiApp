//
//  ProgressView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {
    func makeUIView(context: Self.Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}
