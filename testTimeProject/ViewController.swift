//
//  ViewController.swift
//  testTimeProject
//
//  Created by Игорь on 30.04.2020.
//  Copyright © 2020 Игорь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let button = UIButton(frame: UIScreen.main.bounds)
        button.setTitle("Open RegModule", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc func nextButtonPressed(sender: UIButton!) {
        let nc = RegWireFrame.presentRegViewModule()
        self.present(nc, animated: true)
    }
    
}

