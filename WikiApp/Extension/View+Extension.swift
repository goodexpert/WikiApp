//
//  View+Extension.swift
//  WikiApp
//
//  Created by Seongwuk Park on 17/07/22.
//

import SwiftUI

private struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
    }
}

private struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.weight(.semibold))
    }
}

private struct BodyRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.regular))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func subtitleStyle() -> some View {
        self.modifier(Subtitle())
    }
    
    func bodyStyle() -> some View {
        self.modifier(BodyRegular())
    }
}
