//
//  Bubles.swift
//  ChatBot
//
//  Created by Matias Blum on 30/10/17.
//  Copyright © 2017 Kuragin Dmitriy. All rights reserved.
//

import UIKit

class Bubles0: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.createRectangle()
        
        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 6.0)
        
        //path = UIBezierPath(roundedRect: self.bounds,
                           // byRoundingCorners: [.topLeft, .bottomRight],
                          //  cornerRadii: CGSize(width: 15.0, height: 0.0))
        
        // Specify the fill color and apply it to the path.
        UIColor.white.setFill()
        path.fill()
        
        
        // Specify a border (stroke) color.
        //UIColor.purple.setStroke()
        //path.stroke()
        
    }
    
    func createRectangle() {
        // Initialize the path.
        path = UIBezierPath()
        
        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        
        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        
        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        
        // Create the vertical line from the bottom-right to the top-right side.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        
        // Close the path. This will create the last line automatically.
        path.close()
    }
    
    
}
