//
//  RemoteViewController.swift
//  VRCarApp
//
//  Created by Manik on 19/11/18.
//  Copyright © 2018 Pallak Singh. All rights reserved.
//

import UIKit
import CocoaMQTT

class RemoteViewController: UIViewController {

    private var mqttManager:MQTTManager!
    let ipAddressField = "192.168.0.8"
    let topic = "DriveChannel"
    @IBAction func upButtonPressed(_ sender: Any) {
        mqttManager.publish(with: "0")
        
    }
    
    
    @IBAction func upButtonHold(_ sender: Any) {
        mqttManager.publish(with: "1")
        
    }
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        mqttManager.publish(with: "0")
    }
    
    @IBAction func rightButtonHold(_ sender: Any) {
        mqttManager.publish(with: "3")
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        mqttManager.publish(with: "0")
        
    }

    @IBAction func backButtonHold(_ sender: Any) {
         mqttManager.publish(with: "4")
    }
    @IBAction func leftButtonPressed(_ sender: Any) {
         mqttManager.publish(with: "0")
        
    }
    @IBAction func leftButtonHold(_ sender: Any) {
        mqttManager.publish(with: "2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mqttManager = MQTTManager.shared(host: self.ipAddressField,topic: self.topic)
        self.mqttManager.connect()
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
