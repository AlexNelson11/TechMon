//
//  BattleViewController.swift
//  TechMon
//
//  Created by Alex Nelson on 1/20/16.
//  Copyright © 2016 Alex Nelson. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    
    var moveValueUpTimer: NSTimer!
    
    var enemy: Enemy = Enemy(name: "ドラゴン", imageName:"monster.png")
    var player: Player = Player(name: "勇者", imageName:"yusya.png")
    let util: TechDraUtility = TechDraUtility()
    
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
        // Do any additional setup after loading the view.
        
        moveValueUpTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "moveValueUp", userInfo: nil, repeats: true)
        moveValueUpTimer.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
    enemy.currentMovePoint = enemy.currentMovePoint + 1
        enemyMoveBar.progress = enemy.currentMovePoint / enemy.maxMovePoint
        
        if enemy.currentMovePoint >= enemy.maxMovePoint {
            self.
        }
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


