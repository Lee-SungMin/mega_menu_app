//
//  CarouselView.swift
//  C_Mega_Menu
//
//  Created by 이성민 on 2023/05/13.
//

import SwiftUI

public struct CarouselView<Content: View, Data: Hashable>: View {
    @Binding private var currentIndex: Int
    @State private var drag: CGFloat = 0.0
    @State private var offset: CGFloat = 0
    
    private let dragThreshold = UIScreen.main.bounds.width * 0.2
    private let itemWidth: CGFloat
    private let itemWithSpacing: CGFloat
    private let itemsCount: CGFloat
    private let offsetShift: CGFloat
    
    private let items: [Data]
    private let spacing: CGFloat
    private let content: (Data) -> Content
    
    public init(items: [Data], spacing: CGFloat = 0, currentIndex: Binding<Int>, @ViewBuilder content: @escaping (Data) -> Content) {
        self.items = items
        self.spacing = spacing
        self._currentIndex = currentIndex
        self.content = content
        self.itemWidth = UIScreen.main.bounds.width - spacing * 2
        self.itemsCount = CGFloat(items.count)
        self.itemWithSpacing = itemWidth + spacing
        self.offsetShift = itemWithSpacing * itemsCount / 2 - itemWithSpacing / 2
        self._offset = .init(wrappedValue: self.offsetShift)
        
        // 스크롤 자동 이동
        DispatchQueue.main.async { [self] in
            scrollToCurrentIndex()
        }

    }
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(items, id: \.self) { item in
                content(item)
                    .frame(width: itemWidth)
            }
        }
        .offset(x: offset, y: 0)
        .gesture(DragGesture(minimumDistance: 10)
            .onChanged { currentState in
                self.calculateOffset(currentState.translation.width)
            }
            .onEnded { value in
                self.handleDragEnd(value.translation.width)
            })
        .onAppear {
                // 스크롤 자동 이동
                scrollToCurrentIndex()
            }
    }
    
    private func calculateOffset(_ screenDrag: CGFloat) {
        let activeOffset = offsetShift - (itemWithSpacing * CGFloat(currentIndex))
        let nextOffset = offsetShift - (itemWithSpacing * CGFloat(currentIndex + 1))
        offset = activeOffset
        
        if activeOffset != nextOffset {
            offset = activeOffset + CGFloat(screenDrag)
        }
    }
    
    private func handleDragEnd(_ translationWidth: CGFloat) {
        if translationWidth < -dragThreshold && CGFloat(currentIndex) < itemsCount - 1 {
            currentIndex += 1
        }
        
        if translationWidth > dragThreshold && currentIndex != 0 {
            currentIndex -= 1
        }
        
        withAnimation(.spring(response: 0.25)) {
            calculateOffset(0)
        }
    }
    
    private func scrollToCurrentIndex() {
        let activeOffset = offsetShift - (itemWithSpacing * CGFloat(currentIndex))
        withAnimation(.easeInOut) {
            offset = activeOffset
        }
    }


}
