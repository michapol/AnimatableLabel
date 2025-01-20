//
//  AnimatableLabel.swift
//  AnimatableLabel
//
//  Created by Mike Pollard on 31/03/2023.
//

import UIKit

class AnimatableLabel: UIView {
    var text: String? {
        didSet {
            buildText(from: text)
        }
    }
    var textColor: UIColor = .black

    var textLayers: [CATextLayer] = []

    func buildText(from text: String?) {
        guard let text else {
            textLayers.removeAll()
            return
        }

        var runningOffset: CGFloat = 0

        text.forEach { character in
            let character = String(character)
            let fontSize = 48.0
            let textLayer = CATextLayer()
            textLayer.foregroundColor = textColor.cgColor
            textLayer.backgroundColor = IndictorColor.next.cgColor
            textLayer.fontSize = fontSize
            textLayer.string = character
            let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
            let size = character.size(withAttributes: fontAttributes)
            textLayer.bounds = CGRect(origin: .zero, size: size)
            textLayer.position = CGPoint(x: runningOffset + size.width / 2, y: 10)
            runningOffset += size.width
            print("RunningOffset: \(runningOffset), width: \(size.width), previous: \(runningOffset - size.width)")
            textLayers.append(textLayer)
            layer.addSublayer(textLayer)
        }
    }
}

enum IndictorColor {
    case red
    case green
    case blue

    static var current: IndictorColor = .blue

    static var next: UIColor {
        switch Self.current {
        case .red:  Self.current = .green
        case .green: Self.current = .blue
        case .blue: Self.current = .red
        }

        return Self.current.color
    }

    private var color: UIColor {
        switch self {
        case .red: return UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.25)
        case .green: return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.25)
        case .blue: return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.25)
        }
    }
}
