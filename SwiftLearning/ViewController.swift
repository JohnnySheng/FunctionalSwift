//
//  ViewController.swift
//  SwiftLearning
//
//  Created by Yuangang Sheng on 2018/4/30.
//  Copyright © 2018年 Johnny. All rights reserved.
//

import UIKit

typealias Distance = Double
struct Position{
    var x : Double
    var y : Double
}

extension Position{
    func within(range:Distance) -> Bool {
        return sqrt(x*x + y*y) <= range
    }
}

extension Position{
    func minus(_ p : Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length : Double{
        return sqrt(x*x + y*y)
    }
    
}
struct Ship {
    var position:Position
    var fireRange:Distance
    var unsafeRange:Distance
    
}

extension Ship{
    func canEngage(ship target : Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        return sqrt(dx*dx + dy*dy) <= fireRange
    }
}
extension Ship{
    func canSafelyEngage(ship target:Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        return targetDistance <= fireRange && targetDistance > unsafeRange
    }
}

extension Ship{
    func canSafelyEngage(ship target:Ship, friendly:Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        
        let friendlyDx = friendly.position.x - position.x
        let friendlyDy = friendly.position.y - position.y
        let friendlyDistance = sqrt(friendlyDx*friendlyDx + friendlyDy*friendlyDy)
        
        return targetDistance <= fireRange &&
        targetDistance > unsafeRange &&
        friendlyDistance > unsafeRange
    }
}
extension Ship{
    func canSafelyEngage2(ship target:Ship, friendly:Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(position).length
        
        return targetDistance <= fireRange &&
            targetDistance > unsafeRange &&
            friendlyDistance > unsafeRange
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        struct Position{
            var x : Double
            var y : Double
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

