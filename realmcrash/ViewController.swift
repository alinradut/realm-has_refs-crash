//
//  ViewController.swift
//  realmcrash
//
//  Created by Alin Radut on 11/2/23.
//

import UIKit

class ViewController: UIViewController {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 150, width: 100, height: 40))
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 40)
        button.setTitle("Run test", for: .normal)
        button.addTarget(self, action: #selector(onBtnTapped), for: .touchUpInside)
        view.addSubview(button)

        view.addSubview(label)
    }

    @objc func onBtnTapped() {
        RealmHelper.startWriteTest {
            self.label.text = "\($0)"
        }
        showSharingSheet()
    }

    func showSharingSheet() {
        let activityController = UIActivityViewController(activityItems: ["test"], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = self.view
        activityController.popoverPresentationController?.sourceRect = self.view.frame
        self.present(activityController, animated: true, completion: nil)
    }
}

