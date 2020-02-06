//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by iim jobs on 06/02/20.
//  Copyright © 2020 iim jobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var grid: UIImageView!
    
    var touchedBox: String = "noTouch"
    var touchedBoxesArray = ["noTouch", "noTouch", "noTouch",
                             "noTouch", "noTouch", "noTouch",
                             "noTouch", "noTouch", "noTouch", ]
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var notOrCross: String = "cross"
    
    func drawLines() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 374, height: 374))

        let img = renderer.image { ctx in
            
            // Verticle line 0
            ctx.cgContext.move(to: CGPoint(x: 124.0, y: 0.0))
            ctx.cgContext.addLine(to: CGPoint(x: 124, y: 374))
            
            // Verticle line 1
            ctx.cgContext.move(to: CGPoint(x: 248.0, y: 0.0))
            ctx.cgContext.addLine(to: CGPoint(x: 248, y: 374))
                
            // Horizontal line 0
            ctx.cgContext.move(to: CGPoint(x: 0.0, y: 124.0))
            ctx.cgContext.addLine(to: CGPoint(x: 374, y: 124))
            
            // Horizontat line 1
            ctx.cgContext.move(to: CGPoint(x: 0.0, y: 248.0))
            ctx.cgContext.addLine(to: CGPoint(x: 374, y: 248))
            
            ctx.cgContext.setLineWidth(2)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)

            ctx.cgContext.strokePath()
        }

        grid.image = img
    }
    
    func cordToBoxIndex(_ xCord: Int, _ yCord: Int) -> Int {
        var touchedBoxIndex: Int = -1
        
        if(xCord <= 124 && yCord <= 124) {
            touchedBoxIndex = 0
            touchedBox = "0"
        } else if(xCord > 124 && xCord <= 248 && yCord <= 124) {
            touchedBoxIndex = 1
            touchedBox = "1"
        } else if(xCord > 248 && yCord <= 124) {
            touchedBoxIndex = 2
            touchedBox = "2"
        } else if(xCord < 124 && yCord > 128 && yCord <= 248) {
            touchedBoxIndex = 3
            touchedBox = "3"
        } else if(xCord > 124 && xCord < 248 && yCord > 128 && yCord <= 248) {
            touchedBoxIndex = 4
            touchedBox = "4"
        } else if(xCord > 248 && yCord > 128 && yCord > 128 && yCord <= 248) {
            touchedBoxIndex = 5
            touchedBox = "5"
        } else if(xCord < 124 && yCord > 248) {
            touchedBoxIndex = 6
            touchedBox = "6"
        } else if(xCord > 124 && xCord <= 248 && yCord > 248) {
            touchedBoxIndex = 7
            touchedBox = "7"
        } else if(xCord > 248 && yCord > 248) {
            touchedBoxIndex = 8
            touchedBox = "8"
        }
        return touchedBoxIndex
    }
    
    func checkForWin() -> Bool {
        for combinations in winningCombinations {
            if(touchedBoxesArray[combinations[0]] != "noTouch" && touchedBoxesArray[combinations[0]] == touchedBoxesArray[combinations[1]] && touchedBoxesArray[combinations[1]] == touchedBoxesArray[combinations[2]]) {
                if(touchedBoxesArray[combinations[0]] == "not") {
                    print("WINNER not")
                } else {
                    print("WINNER cross")
                }
                return true
            } else {
                
            }
        }
        return false
    }
    
    func addImage(_ x: Int,_ y: Int,_ name: String) {
        let imageV = UIImageView(frame: CGRect(x: x, y: y, width: 120, height: 120))
        //imageV.center = view.center
        imageV.layer.cornerRadius = 10
        imageV.clipsToBounds = true
        imageV.layer.borderWidth = 2.0
        imageV.layer.borderColor = UIColor.red.cgColor
        imageV.image = UIImage(named: name, in: Bundle(for: type(of: self)), compatibleWith: nil)
        view.addSubview(imageV)
    }
    
    func setImage(_ cord: Int, _ name: String) {
        if(cord < 3) {
            addImage(20 + (124 * cord), 0 + 273, name)
        } else if(cord < 6) {
            addImage(20 + (124 * (cord - 3)), 124 + 273, name)
        } else {
            addImage(20 + (124 * (cord - 6)), 248 + 273, name)
        }
    }
    
    func gridTouch(_ cord: CGPoint) {
        let touchedBoxIndex = cordToBoxIndex(Int(cord.x), Int(cord.y))
        print("Touched Box = \(touchedBoxIndex)")
        
        if(touchedBoxIndex != -1 && touchedBoxesArray[touchedBoxIndex] == "noTouch") {
            if(notOrCross == "cross") {
                touchedBoxesArray[touchedBoxIndex] = "not"
                notOrCross = "not"
                //button\().setImage(<#T##image: UIImage?##UIImage?#>, for: UIControl.State)
                
                setImage(touchedBoxIndex, "Nought.png")
                
            } else {
                touchedBoxesArray[touchedBoxIndex] = "cross"
                notOrCross = "cross"
                
                setImage(touchedBoxIndex, "Cross.png")
            }
            print("Box \(touchedBoxIndex) is \(touchedBoxesArray[touchedBoxIndex])")
        }
        
        if(checkForWin()) {
            print("GAME OVER")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: grid)
            gridTouch(position)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.grid.frame.origin.y)
        drawLines() // Draw grid
    }
    
}

