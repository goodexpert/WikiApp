//
//  ProgressView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI

struct ProgressView: UIViewRepresentable {
    var color: Color = .accentColor
    var style: UIActivityIndicatorView.Style = .medium
    
    func makeUIView(context: Self.Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.color = UIColor(self.color)
        return view
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
