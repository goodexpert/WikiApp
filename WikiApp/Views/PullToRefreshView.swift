//
//  PullToRefreshView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI

struct PullToRefreshView<Content> : View where Content : View {
    @State private var viewState = ViewState()
    
    @Binding var isRefreshing: Bool
    
    var action: () -> Void
    var content: () -> Content
    
    var body: some View {
        ScrollViewReader { proxyReader in
            ScrollView {
                GeometryReader { reader -> AnyView in
                    DispatchQueue.main.async {
                        if viewState.startOffsetY == 0 {
                            viewState.startOffsetY = reader.frame(in: .global).minY
                        }
                        viewState.offsetY = reader.frame(in: .global).minY
                        
                        withAnimation(.easeInOut) {
                            viewState.scrollY = viewState.offsetY - viewState.startOffsetY
                        }
                        
                        if viewState.scrollY > Constants.offsetMargin && !viewState.isDragging {
                            withAnimation(.easeIn) {
                                viewState.isDragging = true
                            }
                        } else if viewState.offsetY == viewState.startOffsetY && viewState.isDragging && !isRefreshing {
                            withAnimation(.linear) {
                                viewState.isDragging = false
                                isRefreshing = true
                            }
                            action()
                        }
                    }
                    return AnyView(Color.black.frame(width: 0, height: 0))
                }
                
                ZStack(alignment: .top) {
                    if isRefreshing {
                        ProgressView()
                            .offset(y: -Constants.offsetY)
                    } else {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.gray)
                            .rotationEffect(.init(degrees: viewState.isDragging ? 180 : 0))
                            .offset(y: -Constants.offsetY)
                    }
                    
                    content()
                }
                .id(Constants.id)
                .offset(y: isRefreshing ? Constants.offsetY : 0)
            }
            .background(Color.black.opacity(0.06).ignoresSafeArea())
            .overlay(
                Button(action: {
                    withAnimation(.spring()) {
                        proxyReader.scrollTo(Constants.id, anchor: .top)
                    }
                }) {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
                }
                    .padding(.trailing)
                    .opacity(-viewState.scrollY > Constants.scrollY ? 1 : 0)
                , alignment: .bottomTrailing
            )
        }
    }
}

fileprivate struct ViewState {
    var startOffsetY: CGFloat = 0
    var offsetY: CGFloat = 0
    var scrollY: CGFloat = 0
    var isDragging: Bool = false
}

fileprivate struct Constants {
    static let id = "SCROLL_TO_TOP"
    static let offsetMargin: CGFloat = 80
    static let offsetY: CGFloat = 35
    static let scrollY: CGFloat = 350
}

struct PullToRefreshView_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshView(isRefreshing: .constant(false), action: {
            print("Update data....")
        }) {
            Text("Hello World!")
        }
    }
}
