//
//  ViewController.swift
//  AnimatableLabel
//
//  Created by Mike Pollard on 31/03/2023.
//

import UIKit

class ViewController: UIViewController {

    let label = AnimatableLabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupLabel()
        layout()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        for (index, character) in label.textLayers.enumerated() {
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = character.position
            animation.toValue = CGPoint(x: character.position.x + 10, y: character.position.y - 20)
            animation.duration = 0.3
            animation.beginTime = 1.0 / Double(label.text!.count) * Double(index)
            animation.autoreverses = true
            animation.repeatCount = .infinity

            character.add(animation, forKey: "position")
        }
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupLabel() {
        label.textColor = .black
        label.text = " Hello World! "
    }

    private func layout() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}

