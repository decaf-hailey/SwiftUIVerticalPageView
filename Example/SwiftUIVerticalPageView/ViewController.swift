//
//  ViewController.swift
//  SwiftUIVerticalPageView
//
//  Created by decaf-hailey on 02/04/2023.
//  Copyright (c) 2023 decaf-hailey. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childVC = UIHostingController(rootView: ContentView())
        let childView = childVC.view!
        childView.translatesAutoresizingMaskIntoConstraints = false
        addChild(childVC)
        view.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            childView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         ])
        childVC.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

