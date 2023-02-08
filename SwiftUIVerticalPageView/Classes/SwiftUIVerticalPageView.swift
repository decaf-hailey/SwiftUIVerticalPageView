//
//  SwiftUIVerticalPageView.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/01/22.
//

import SwiftUI
import Combine

public struct SwiftUIVerticalPageView<Content: View, Model: Identifiable>: View {
    
    @State private var offset: CGFloat = 0
    @State var itemSize : CGSize = CGSize.zero
    
    @Binding var currentIndex: Int
    var models : [Model]
    
    var builder : (Model) -> Content
    let duration: Double
    public init(currentIndex: Binding<Int>,
         models: [Model],
         spacing: CGFloat,
         itemWidthMinus: CGFloat,
         duration: Double = 0.3,
         @ViewBuilder builder : @escaping (Model) -> Content){
        self._currentIndex = currentIndex
        self.models = models
        self.duration = duration
        self.builder = builder
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 0) {
                    ForEach(models) { each in
                        self.builder(each)
                            .frame(width: itemSize.width, height: itemSize.height)
                    }
                }
            }
            .content.offset(y:self.offset)
            .onReceive(Just(currentIndex), perform: { output in
                withAnimation(.easeInOut(duration: duration)) {
                    self.offset = output < 0 ? 0 : (itemSize.height) * CGFloat(output) * -1
                }
            })
            .gesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .local)
                    .onEnded({ value in
                        if abs(value.predictedEndTranslation.height) >= (itemSize.height) / 2 {
                            var nextIndex: Int = (value.predictedEndTranslation.height < 0) ? 1 : -1
                            nextIndex += self.currentIndex
                            let curr = nextIndex.keepIndexInRange(min: 0, max: self.models.endIndex - 1)
                            currentIndex = curr
                        }
                        withAnimation(.easeInOut(duration: duration)) {
                            self.offset = -(itemSize.height) * CGFloat($currentIndex.wrappedValue)
                        }
                    })
            )
            .onAppear(perform: {
                itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            })
        }
    }
}


extension Int {
    func toCGFloat() -> CGFloat {
        CGFloat(self)
    }
    
    func keepIndexInRange(min: Int, max: Int) -> Int {
        switch self {
        case ..<min: return min
        case max...: return max
        default: return self
        }
    }
}
