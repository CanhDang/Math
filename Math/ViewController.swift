//
//  ViewController.swift
//  Math
//
//  Created by HuuLuong on 7/11/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbl_n1: UILabel!
    
    @IBOutlet weak var lbl_n2: UILabel!
    
    @IBOutlet weak var btn_ans1: UIButton!
    
    @IBOutlet weak var btn_ans2: UIButton!
    
    @IBOutlet weak var btn_ans3: UIButton!
    
    @IBOutlet weak var lbl_sign: UILabel!
    
    @IBOutlet weak var lbl_time: UILabel!
    
    @IBOutlet weak var lbl_score: UILabel!
    
    var time = 60; // to count down time
    
    var timer = NSTimer()
    
    let btn1 = 100;
    let btn2 = 50;
    let btn3 = 10;
    
    var score = 0;
    
    var result: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRandom()
 
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(num), userInfo: nil, repeats: true)

    }
    
    
    @IBAction func btn_action(sender: UIButton) {
        
        let result1 = Int(sender.currentTitle!)
        
        if result1 == result {
            score += 1
        }
        if time > 0 {
            setRandom()
        }
      
    }
    
    func setRandom() {
    
        //generate 2 random numbers
        let random1 = Int(arc4random_uniform(9)+1) // range: 0+1 to 8+1
        var random2 = Int(arc4random_uniform(9)+1)
        
        //show 2 random numbers to View
        
        
        let randomSign = Int(arc4random_uniform(4)) // to set random sign
        let randomPosition = Int(arc4random_uniform(3))+1; // to set random position of true result;
        
        if randomSign == 3 {
            random2 = randomDivisor(random1)
        }
        
        lbl_n1.text = String(random1)
        
        lbl_n2.text = String(random2)
        
        setResult(random1,randomB: random2,sign: randomSign, position: randomPosition)
    
    }
    
    func randomDivisor(dividend: Int) -> Int{
        var divisor: Int = 1;
        var count: UInt32 = 0; // to count number of divisor
        for var i = 1; i<=dividend; i += 1 {
            if dividend % i == 0 {
                count += 1
            }
          }
        
        let randomDivisorPosition = UInt32(arc4random_uniform(count)+1)
        
        count = 0;
        for var i = 1; i<=dividend; i += 1 {
            if dividend % i == 0 {
                count += 1
                if count == randomDivisorPosition {
                    divisor  = i;
                    break;
                }
            }
        }
        
        return divisor
    }
    
    func num(){
       if time >= 0 {
       lbl_time.text = String(time)
       time -= 1
       lbl_score.text = String(score)
       } else {
            self.timer.invalidate()
            viewAlertDialog();
       }
        
    }
    
    
    func setResult(randomA: Int, randomB: Int, sign: Int, position: Int){
        
        //if = 0 -> sign = "-" ; if = 1 -> sign = "+"; if = 2 -> sign = "x" ; if = 3 -> sign = "/"
        
        if sign == 0 {
            result = randomA - randomB
            lbl_sign.text = "-"
        } else if sign == 1 {
            lbl_sign.text = "+"
            result = randomA + randomB
        } else if sign == 2{
            lbl_sign.text = "x"
            result = randomA * randomB
        } else if sign == 3{
            lbl_sign.text = "/"
            result = randomA / randomB
            
        }
        
        let rangeOfResult: UInt32 = 81 // 9*9 = 81
       
        var fakeResult1 = Int(arc4random_uniform(rangeOfResult)+1)
        while (fakeResult1 == result) { fakeResult1 = Int(arc4random_uniform(rangeOfResult)+1) }
    
        var fakeResult2 = Int(arc4random_uniform(rangeOfResult)+1)
        while (fakeResult2 == result) { fakeResult2 = Int(arc4random_uniform(rangeOfResult)+1) }
     
        switch (position){
        case 1:
            btn_ans1.setTitle(String(result), forState: .Normal)
            btn_ans2.setTitle(String(fakeResult1), forState: .Normal)
            btn_ans3.setTitle(String(fakeResult2), forState: .Normal)
            
            break;
        case 2:
            btn_ans1.setTitle(String(fakeResult1), forState: .Normal)
            btn_ans2.setTitle(String(result), forState: .Normal)
            btn_ans3.setTitle(String(fakeResult2), forState: .Normal)
           
            break;
        default:
            btn_ans1.setTitle(String(fakeResult1), forState: .Normal)
            btn_ans2.setTitle(String(fakeResult2), forState: .Normal)
            btn_ans3.setTitle(String(result), forState: .Normal)
            
        }
      
    }
    
    func viewAlertDialog(){
        
        let alert = UIAlertController(title:"Game Over", message: "Would you like to play again?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title:"Play Again", style: UIAlertActionStyle.Default, handler: { (action) in
            self.restart()
            
        }))
        
        alert.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func restart(){
        time = 60;
        setRandom();
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(num), userInfo: nil, repeats: true)
    }
}

