//
//  ViewController.swift
//  realmcrash
//
//  Created by Alin Radut on 11/2/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("Run test", for: .normal)
        button.addTarget(self, action: #selector(onBtnTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func onBtnTapped() {
        RealmHelper.startWriteTest()
    }
}

