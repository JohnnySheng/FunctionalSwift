//
//  ViewController.swift
//  SwiftLearning
//
//  Created by Yuangang Sheng on 2018/4/30.
//  Copyright © 2018年 Johnny. All rights reserved.
//

import UIKit

typealias Distance = Double
typealias Region = (Position) -> Bool
func circle(redius : Distance) -> Region {
    return {
        point in point.length < redius
    }
}
func shift(_ region:@escaping Region, by offset: Position) -> Region {
    return { point in region(point.minus(offset))}
}

func invert(_ region: @escaping Region) -> Region {
    return { point in !region(point)}
}

func intersect(_ region: @escaping Region, with other:@escaping Region) -> Region {
    return{ point in region(point) && other(point)}
}

func union(_ region: @escaping Region, with other: @escaping Region) -> Region{
    return{ point in region(point) || other(point)}
}

func subtract(_ region: @escaping Region, from original: @escaping Region) -> Region {
    return intersect(original, with: invert(region))
}

struct Region1 {
    let lookup:(Position) -> Bool
}
//
//
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
    
    func circle(redius : Distance) -> Region {
        return {
            point in point.length < redius
        }
    }
    
    func circle2(redius: Distance, center:Position) -> Region {
        return {
            point in point.minus(center).length < redius
        }
    }
    
    

  

    var length : Double{
        return sqrt(x*x + y*y)
    }
}
//
//
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
        
//        let shifted = target.position.shift(circle(redius: 10), by:Position(x: 5, y:5))
        
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(position).length
        
        return targetDistance <= fireRange &&
            targetDistance > unsafeRange &&
            friendlyDistance > unsafeRange
    }
}

extension Ship{
    func canSafelyEngage3(ship target: Ship, friendly:Ship) -> Bool {
        let rangeRegion = subtract(circle(redius:unsafeRange), from: circle(redius: fireRange))
        let fireRegion = shift(rangeRegion, by: position)
        
        let friendlyRegion = shift(circle(redius: unsafeRange), by: friendly.position)
        let resultRegion = subtract(friendlyRegion, from: fireRegion)
        return resultRegion(target.position)
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

