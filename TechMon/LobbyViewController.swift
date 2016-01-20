//
//  LobbyViewController.swift
//  TechMon
//
//  Created by Alex Nelson on 1/20/16.
//  Copyright © 2016 Alex Nelson. All rights reserved.
//

import UIKit
import AVFoundation

class LobbyViewController: UIViewController ,AVAudioPlayerDelegate {

    var stamina: Float = 0
    var staminaTimer: NSTimer!
    var util: TechDraUtility!
    var player: Player!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    player = Player(name: "勇者", imageName: "yusya.png")
        staminaBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = "Lv. 15"
        stamina = 100
        
        util = TechDraUtility()
        
        cureStamina()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        util.playBGM("lobby")
    }
    
    override func viewWillDisappear(animated: Bool) {
        util.stopBGM()
    }
    
    @IBAction func toBattle() {
        
        if stamina >= 50 {
            stamina = stamina - 50
            staminaBar.progress = stamina / 100
            
            self.performSegueWithIdentifier("toBattle", sender: nil)
        }else{
            let alert = UIAlertController(title: "Cannot go to battle" , message: "not enough stamina", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
