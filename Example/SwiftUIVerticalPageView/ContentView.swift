//
//  ContentView.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/01/21.
//

import SwiftUI
import Combine
import SwiftUIVerticalPageView

struct ContentView: View {
    @StateObject var viewModel: ViewModel = ViewModel()
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    var body: some View {
        SwiftUIVerticalPageView(currentIndex: $viewModel.currentPage, models: $viewModel.data.wrappedValue ?? [], spacing: 0, itemWidthMinus: 0) { each in
            eachView(each)
        }
        .background(Color.gray.opacity(0.6))
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            viewModel.setData()
        })
    }
    
    func eachView(_ data: Singer) -> some View {
        if #available(iOS 15, *) {
            return descriptionView(data)
                .background(
                    AsyncImage(url: URL(string: data.picture)) { image in
                        image.resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                )
        } else {
            return descriptionView(data)
                .background(Image(systemName: "\(data.name).jpeg"))
        }

    }
    
    func descriptionView(_ data: Singer) -> some View {
        
        ZStack {
            LinearGradient(colors:  [Color.gray.opacity(0.6), Color.clear, Color.clear], startPoint: data.upside ? .top : .bottom, endPoint: data.upside ? .bottom : .top)
            VStack(alignment: .leading) {
                if !data.upside {
                    Spacer()
                }
                Text(data.name).foregroundColor(.black)
                    .font(.title)
                    .padding(.bottom)
                Text(data.desc).foregroundColor(.white)
                    .font(.title3)
                if data.upside {
                    Spacer()
                }
            }
            .padding(.top, safeAreaInsets.top)
            .padding(.bottom, safeAreaInsets.bottom)
            .padding([.leading, .trailing], 10)
        }
        
        

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
