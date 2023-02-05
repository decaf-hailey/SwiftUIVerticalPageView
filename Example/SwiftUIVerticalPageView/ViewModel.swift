//
//  ViewModel.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/02/04.
//

import Foundation

extension ContentView {
    class ViewModel: ObservableObject {
        @Published var currentPage: Int = 0
        @Published var data : [Singer]?
        
        func setData(){
            data = Util.fromMock(dataType: [Singer].self, forResource: "data")
        }
    }
}
