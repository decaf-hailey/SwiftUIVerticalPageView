//
//  Util.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/01/22.
//

import Foundation
import UIKit

enum Util {
    
    enum UI {
        static func screenWidth () -> CGFloat {
            UIScreen.main.bounds.width
        }
        static func screenHeight() -> CGFloat{
            UIScreen.main.bounds.height
        }
        
        static func getKeyWindow() -> UIWindow? {
            let key = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            return key
        }
        
        static func makeKeyAndVisible(_ vc: UIViewController?, _ appdelegateWindow: UIWindow? = nil) {
            //appdelegate용
            if appdelegateWindow != nil {
                appdelegateWindow?.rootViewController = vc
                appdelegateWindow?.makeKeyAndVisible()
                return
            }
            
            //그 외 모두
            if #available(iOS 13.0, *) {
                let key = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                
                key?.rootViewController = vc
                key?.makeKeyAndVisible()
            } else {
                UIApplication.shared.keyWindow?.rootViewController = vc
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
            }
        }
        
        static func getSafeAreaInsets() -> UIEdgeInsets {
            Util.UI.getKeyWindow()?.safeAreaInsets ?? .zero
        }
    }
    
    static func fromMock<T:Codable>(dataType: T.Type, forResource: String) ->T? {
        guard let path = Bundle.main.path(forResource: forResource, ofType: "json") else {
            return nil
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return nil
        }
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data,
           let _data = try? decoder.decode(T.self, from: data) {
            return _data
        } else {
            return nil
        }
        
        
    }
}
