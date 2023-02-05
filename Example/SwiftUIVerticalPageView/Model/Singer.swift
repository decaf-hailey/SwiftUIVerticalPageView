//
//  Singer.swift
//  SwiftUIVerticalPageView_Example
//
//  Created by Hailey on 2023/02/05.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

struct Singer : Codable, Identifiable {
    let id : Int
    let picture: String
    let upside: Bool
    let name: String
    let desc: String
}
