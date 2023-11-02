//
//  ShareViewController.swift
//  realmcrash share
//
//  Created by Alin Radut on 11/2/23.
//

import UIKit
import Social

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("Run test", for: .normal)
        button.addTarget(self, action: #selector(onBtnTapped), for: .touchUpInside)
        view.addSubview(button)
    }

    @objc func onBtnTapped() {
        RealmHelper.startReadTest()
    }
}
