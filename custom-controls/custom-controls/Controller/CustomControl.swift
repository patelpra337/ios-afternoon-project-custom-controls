//
//  CustomControl.swift
//  custom-controls
//
//  Created by patelpra on 4/16/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var labels: [UILabel] = []
    var value: Int = 1
    
    private let componentDimension: CGFloat = 40.0
    private let componentCount: Int = 5
    private let componentActiveColor: UIColor = .black
    private let componentInactiveColor: UIColor = .gray
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        self.setup()
    }
    
    private func setup() {
        let spacing: CGFloat = 8.0
        var x: CGFloat = spacing
        
        for i in 0..<self.componentCount {
            let label = UILabel()
            addSubview(label)
            label.tag = i + 1
            labels.append(label)
            label.frame.size = CGSize(width: componentDimension, height: componentDimension)
            label.frame.origin = CGPoint(x: x, y: 0.0)
            x += componentDimension + spacing
            label.font = UIFont.boldSystemFont(ofSize: 32.0)
            label.text = "⭐️"
            label.textAlignment = .center
            if label.tag == 1 {
                label.textColor = componentActiveColor
            } else {
                label.textColor = componentInactiveColor
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
      let componentsWidth = CGFloat(componentCount) * componentDimension
      let componentsSpacing = CGFloat(componentCount + 1) * 8.0
      let width = componentsWidth + componentsSpacing
      return CGSize(width: width, height: componentDimension)
    }
    
    private func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        
        for label in self.labels {
            if label.frame.contains(touchPoint) {
                if self.value != label.tag {
                self.value = label.tag
                    
                    for label in self.labels {
                        if label.tag <= value {
                            label.textColor = componentActiveColor
                        } else {
                            label.textColor = componentInactiveColor
                        }
                    }
                    
                    sendActions(for: .valueChanged)
                    
                }
            }
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchDragInside, .valueChanged])
            updateValue(at: touch)
            
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            sendActions(for: [.touchUpInside, .valueChanged])
            updateValue(at: touch)
        } else {
            sendActions(for: [.touchCancel])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
    sendActions(for: [.touchCancel])
        
    }    
}
