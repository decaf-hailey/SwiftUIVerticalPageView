//
//  environment+Extension.swift
//  SwiftUIVerticalPageView
//
//  Created by Hailey on 2023/02/04.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        let final = Util.UI.getSafeAreaInsets()
        return EdgeInsets(top: final.top, leading: final.left, bottom: final.bottom, trailing: final.right)
    }
}
