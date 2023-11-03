//
//  ShareViewController.swift
//  realmcrash share
//
//  Created by Alin Radut on 11/2/23.
//

import UIKit
import Social

class ShareViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 150, width: 100, height: 40))
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("Run test", for: .normal)
        button.addTarget(self, action: #selector(onBtnTapped), for: .touchUpInside)
        view.addSubview(button)

        view.addSubview(label)
    }

    @objc func onBtnTapped() {
        RealmHelper.startReadTest {
            self.label.text = "\($0)"
        }
    }
}
