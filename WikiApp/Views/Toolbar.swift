//
//  Toolbar.swift
//  WikiApp
//
//  Created by Seongwuk Park on 17/07/22.
//

import SwiftUI

struct Toolbar: View {
    @Binding var selectedIndex: Int;
    
    private let toolbarItems = [ "character", "episode", "location" ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach((0..<toolbarItems.count), id: \.self) { index in
                    ToolbarItem(content: toolbarItems[index].localized, isSelected: (self.selectedIndex == index))
                        .onTapGesture {
                            withAnimation {
                                self.selectedIndex = index
                            }
                        }
                }
            }
            .padding()
        }
    }
}

fileprivate struct ToolbarItem: View {
    let content: String
    let isSelected: Bool
    
    var body: some View {
        Text(content)
            .bodyStyle()
            .padding(Constants.margin)
            .background(self.isSelected ? Color.menuTextDeactive : Color.menuTextActive)
            .foregroundColor(self.isSelected ? Color.menuTextActive : Color.menuTextDeactive)
            .clipShape(Capsule())
    }
    
    private struct Constants {
        static let margin: CGFloat = 8
        static let radius: CGFloat = 32
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        Toolbar(selectedIndex: .constant(0))
    }
}
