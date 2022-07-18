//
//  View+Extension.swift
//  WikiApp
//
//  Created by Seongwuk Park on 17/07/22.
//

import SwiftUI

private struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.bold))
    }
}

private struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.weight(.bold))
    }
}

private struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .semibold))
    }
}

private struct Headline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold))
    }
}

private struct Label: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.semibold))
    }
}

private struct Link: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.semibold))
            .foregroundColor(.accentColor)
    }
}

private struct BodyRegular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.regular))
    }
}

extension View {
    func largeTitleStyle() -> some View {
        self.modifier(LargeTitle())
    }
    
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func subtitleStyle() -> some View {
        self.modifier(Subtitle())
    }
    
    func headlineStyle() -> some View {
        self.modifier(Headline())
    }
    
    func labelStyle() -> some View {
        self.modifier(Label())
    }
    
    func linkStyle() -> some View {
        self.modifier(Link())
    }
    
    func bodyStyle() -> some View {
        self.modifier(BodyRegular())
    }
}
