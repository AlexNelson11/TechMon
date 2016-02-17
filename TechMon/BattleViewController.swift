//
//  BattleViewController.swift
//  TechMon
//
//  Created by Alex Nelson on 1/20/16.
//  Copyright © 2016 Alex Nelson. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    let saveData:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var moveValueUpTimer: NSTimer!
    
    var enemy: Enemy = Enemy(name: "ドラゴン", imageName:"monster.png")
    var player: Player = Player(name: "勇者", imageName:"yusya.png")
    let util: TechDraUtility = TechDraUtility()
    
    var settingUp: Bool! = true
    
    var isPlayerMoveValueMax: Bool! = true
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var attackButton: UIButton!
    @IBOutlet var fireButton: UIButton!
    @IBOutlet var tameruButton: UIButton!
    
    @IBOutlet var enemyImageView:UIImageView!
    @IBOutlet var playerImageView:UIImageView!
    
    @IBOutlet var enemyHPBar:UIProgressView!
    @IBOutlet var playerHPBar:UIProgressView!
    @IBOutlet var playerMoveBar:UIProgressView!
    @IBOutlet var enemyMoveBar:UIProgressView!
    @IBOutlet var playerTPBar:UIProgressView!
    
    @IBOutlet var enemyNameLabel:UILabel!
    @IBOutlet var playerNameLabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if saveData.objectForKey("difficultyDown") != nil {
        player.maxHP = saveData.objectForKey("difficultyDown") as! Float
        }else{
            player.maxHP = 100
        }
        if saveData.objectForKey("difficultyUp") != nil {
        enemy.attackPoint = saveData.objectForKey("difficultyUp") as! Float
        }else{
            enemy.attackPoint = 30
        }
        self.setup()
        // Do any additional setup after loading the view.
        
        moveValueUpTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "moveValueUp", userInfo: nil, repeats: true)
        moveValueUpTimer.fire()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        func setup() {
            if settingUp == true {
                enemy.currentHP = enemy.maxHP
                
                player.currentHP = player.maxHP
                
                player.currentTP = 0
                
                enemyHPBar.progress = 1
                playerHPBar.progress = 1
                playerTPBar.progress = 0
                
                settingUp = false

            }
        }
    
    
    func initStatus() {
        
        enemyNameLabel.text = enemy.name
        playerNameLabel.text = player.name
        
        enemyImageView.image = enemy.image
        playerImageView.image = player.image
        
        enemyHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerHPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        playerTPBar.transform = CGAffineTransformMakeScale(1.0, 4.0)
        
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        playerHPBar.progress = player.currentHP / player.maxHP
        playerTPBar.progress = player.currentTP / player.maxTP
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        util.playBGM("BGM_battle001")
    }
    
    func moveValueUp() {
        
        player.currentMovePoint = player.currentMovePoint + 1
        playerMoveBar.progress = player.currentMovePoint / player.maxMovePoint
        
        if player.currentMovePoint >= player.maxMovePoint {
            isPlayerMoveValueMax = true
            player.currentMovePoint = player.maxMovePoint
        }else{
            isPlayerMoveValueMax = false
        }
        
        
        enemy.currentMovePoint = enemy.currentMovePoint + 1
        enemyMoveBar.progress = enemy.currentMovePoint / enemy.maxMovePoint
        
        if enemy.currentMovePoint >= enemy.maxMovePoint {
            self.enemyAttack()
            enemy.currentMovePoint = 0
        }
    }
    
    func enemyAttack() {
        
        TechDraUtility.damageAnimation(playerImageView)
        util.playSE("SE_attack")
        
        player.currentHP = player.currentHP - enemy.attackPoint
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
        
        if player.currentHP <= 0.0 {
            finishBattle(playerImageView, winPlayer: false)
        }
    }
    
    @IBAction func attackAction() {
        
        if isPlayerMoveValueMax == true {
            TechDraUtility.damageAnimation(enemyImageView)
            util.playSE("SE_attack")
            
            enemy.currentHP = enemy.currentHP - player.attackPoint
            enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
            
            player.currentMovePoint = 0
            
            player.currentTP = player.currentTP + 10
            if player.currentTP >= player.maxTP {
            player.currentTP = player.maxTP
            }
            playerTPBar.progress = player.currentTP / player.maxTP
            
            if enemy.currentHP <= 0.0 {
                finishBattle(enemyImageView, winPlayer: true)
            }
            
            
        }
    }
    
    @IBAction func fireAction() {
        if isPlayerMoveValueMax == true && player.currentTP >= 40  {
            
           
            TechDraUtility.damageAnimation(enemyImageView)
            util.playSE("SE_fire")
            
            enemy.currentHP = enemy.currentHP - 100
            enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated: true)
            
            player.currentTP = player.currentTP - 40
            
              playerTPBar.progress = player.currentTP / player.maxTP
            
            player.currentMovePoint = 0
            
                       if player.currentTP >= player.maxTP {
                player.currentTP = player.maxTP
            }
            playerTPBar.progress = player.currentTP / player.maxTP
            
            if enemy.currentHP <= 0.0 {
                finishBattle(enemyImageView, winPlayer: true)
            
   
            }
        }
    }
    @IBAction func tameruAction() {
        if isPlayerMoveValueMax == true && player.currentTP >= 20 {
            
       
                        util.playSE("SE_charge")
            
            player.attackPoint = player.attackPoint + 30
            player.currentTP = player.currentTP - 20
                        playerTPBar.progress = player.currentTP / player.maxTP
            
            player.currentMovePoint = 0
            
           
            
            playerTPBar.progress = player.currentTP / player.maxTP
            
            
        }
    }

        func finishBattle(vanishImageView: UIImageView,winPlayer: Bool){
            TechDraUtility.vanishAnimation(vanishImageView)
            util.stopBGM()
            moveValueUpTimer.invalidate()
            isPlayerMoveValueMax = false
            
            let finishedMessage: String
            
            if attackButton.hidden != true {
                attackButton.hidden = true
                
            }
            if fireButton.hidden != true {
                fireButton.hidden = true
                
            }
            if tameruButton.hidden != true {
                tameruButton.hidden = true
                
            }
            
            if winPlayer == true {
                util.playSE("SE_fanfare")
                finishedMessage = "You win!!"
                
                enemy.attackPoint = enemy.attackPoint + 10
                
                saveData.setObject(enemy.attackPoint, forKey: "difficultyUp")
                saveData.synchronize()
                
                  self.performSegueWithIdentifier("toLobby", sender: nil)
            }else{
                util.playSE("SE_gameover")
                finishedMessage = "You lose"
                
                player.maxHP = player.maxHP + 40
                
                 saveData.setObject(player.maxHP, forKey: "difficultyDown")
                saveData.synchronize()
                
                self.performSegueWithIdentifier("toLobby", sender: nil)
            }
            let alert = UIAlertController(title: "Battle!", message: finishedMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil)}))
            }
    
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
This Storyboard that application, of cradle is in charge the 1 bureaucratic principle provides that the part that precedes the operation is small, to imagine fréquentement

He brings selects again provides regolator about the viewpoint
*/


