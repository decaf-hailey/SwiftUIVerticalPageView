//
//  int+Extension.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/01/22.
//

import Foundation

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
