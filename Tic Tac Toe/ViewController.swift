//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by iim jobs on 06/02/20.
//  Copyright © 2020 iim jobs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var grid: UIImageView!
    
    let lineWidth: Int = 1
    
    let screenWidth  = Int(UIScreen.main.bounds.width)
    let screenHeight = Int(UIScreen.main.bounds.height)
    
    var touchedBox: String = "noTouch"
    var touchedBoxesArray = ["noTouch", "noTouch", "noTouch",
                             "noTouch", "noTouch", "noTouch",
                             "noTouch", "noTouch", "noTouch", ]
    
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var notOrCross: String = "cross"
    
    func drawLines() {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: screenWidth, height: screenWidth))

        let img = renderer.image { ctx in
            
            let screenWidthOneThird: Int = screenWidth / 3
            
            // Verticle line 0
            ctx.cgContext.move(to: CGPoint(x: screenWidthOneThird, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: screenWidthOneThird, y: screenWidth))
            
            // Verticle line 1
            ctx.cgContext.move(to: CGPoint(x: screenWidthOneThird * 2, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: screenWidthOneThird * 2, y: screenWidth))
                
            // Horizontal line 0
            ctx.cgContext.move(to: CGPoint(x: 0, y: screenWidthOneThird))
            ctx.cgContext.addLine(to: CGPoint(x: screenWidth, y: screenWidthOneThird))
            
            // Horizontat line 1
            ctx.cgContext.move(to: CGPoint(x: 0, y: screenWidthOneThird * 2))
            ctx.cgContext.addLine(to: CGPoint(x: screenWidth, y: screenWidthOneThird * 2))
            
            ctx.cgContext.setLineWidth(CGFloat(lineWidth))
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)

            ctx.cgContext.strokePath()
        }

        grid.image = img
    }
    
    func cordToBoxIndex(_ xCord: Int, _ yCord: Int) -> Int {
        var touchedBoxIndex: Int = -1
        
        let screenWidthOneThird: Int = screenWidth / 3
        
        if(xCord <= screenWidthOneThird && yCord <= screenWidthOneThird) {
            touchedBoxIndex = 0
            touchedBox = "0"
        } else if(xCord > screenWidthOneThird && xCord <= screenWidthOneThird * 2 && yCord <= screenWidthOneThird) {
            touchedBoxIndex = 1
            touchedBox = "1"
        } else if(xCord > screenWidthOneThird * 2 && yCord <= screenWidthOneThird) {
            touchedBoxIndex = 2
            touchedBox = "2"
        } else if(xCord < screenWidthOneThird && yCord > screenWidthOneThird && yCord <= screenWidthOneThird * 2) {
            touchedBoxIndex = 3
            touchedBox = "3"
        } else if(xCord > screenWidthOneThird && xCord < screenWidthOneThird * 2 && yCord > screenWidthOneThird && yCord <= screenWidthOneThird * 2) {
            touchedBoxIndex = 4
            touchedBox = "4"
        } else if(xCord > screenWidthOneThird * 2 && yCord > screenWidthOneThird && yCord > screenWidthOneThird && yCord <= screenWidthOneThird * 2) {
            touchedBoxIndex = 5
            touchedBox = "5"
        } else if(xCord < screenWidthOneThird && yCord > screenWidthOneThird * 2) {
            touchedBoxIndex = 6
            touchedBox = "6"
        } else if(xCord > screenWidthOneThird && xCord <= screenWidthOneThird * 2 && yCord > screenWidthOneThird * 2) {
            touchedBoxIndex = 7
            touchedBox = "7"
        } else if(xCord > screenWidthOneThird * 2 && yCord > screenWidthOneThird * 2) {
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
        let imageV = UIImageView(frame: CGRect(x: x, y: y, width: (screenWidth / 3) - (lineWidth * 2), height: (screenWidth / 3) - (lineWidth * 2)))
        imageV.clipsToBounds = true
        imageV.image = UIImage(named: name, in: Bundle(for: type(of: self)), compatibleWith: nil)
        grid.addSubview(imageV)
    }
    
    func setImage(_ cord: Int, _ name: String) {
        let screenWidthOneThird: Int = screenWidth / 3
        
        if(cord < 3) {
            addImage((screenWidthOneThird * cord) + lineWidth, 0 + lineWidth, name)
        } else if(cord < 6) {
            addImage(((screenWidthOneThird * (cord - 3)) + lineWidth), screenWidthOneThird + lineWidth, name)
        } else {
            addImage(((screenWidthOneThird * (cord - 6)) + lineWidth), (screenWidthOneThird * 2) + lineWidth, name)
        }
    }
    
    func gridTouch(_ cord: CGPoint) {
        let touchedBoxIndex = cordToBoxIndex(Int(cord.x), Int(cord.y))
        print("Touched Box = \(touchedBoxIndex)")
        
        if(touchedBoxIndex != -1 && touchedBoxesArray[touchedBoxIndex] == "noTouch") {
            if(notOrCross == "cross") {
                touchedBoxesArray[touchedBoxIndex] = "not"
                notOrCross = "not"
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
    
    func addCanvas() {
        grid = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenWidth))
        grid.clipsToBounds = true
        view.addSubview(grid)
        
        grid.center = view.center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCanvas() // Add image for drawing area
        drawLines() // Draw grid
    }
    
}

