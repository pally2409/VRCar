//
//  SettingsViewController.swift
//  VRCarApp
//
//  Created by Pallak Singh on 17/11/18.
//  Copyright © 2018 Pallak Singh. All rights reserved.
//

import UIKit
import CoreData
import CocoaMQTT
import CoreMotion


class SettingsViewController: UIViewController {
    @IBOutlet weak var carSpeedOptions: UISegmentedControl!
    private var mqttManager:MQTTManager!
    var motionManager = CMMotionManager()
    @IBOutlet weak var drivingModeSwitch: UISwitch!
    var gyroModeSet = false
    var isFirst  = true;
    var flag = 0
    var flagz = 0
    @IBAction func onSwitchChanged(_ sender: Any) {
        
        if drivingModeSwitch.isOn {
            isFirst  = true;
            flag = 0
            flagz = 0
            gyroModeSet = true
            mqttManager = MQTTManager.shared(host: ipAddressField,topic: topic)
            mqttManager.connect()
            var initialAttitude = CMAttitude()
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical, to: OperationQueue.current!){ (motiondata, err) in
                guard let data = motiondata else {return}
                if self.isFirst == true {
                    initialAttitude = data.attitude
                    self.isFirst = false
                } else {
                    let attitude = data.attitude
                    attitude.multiply(byInverseOf: initialAttitude)
                    let pitch = self.radiansToDegrees(attitude.pitch)
                    let roll = self.radiansToDegrees(attitude.roll)
                    
                    print(pitch)
                    if pitch < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "3")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if pitch > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "2")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "4")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "1")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    } else if roll < 50 && roll > -50 && pitch < 50 && pitch > -50 {
                        if self.flagz < 1{
                            self.mqttManager.publish(with: "0")
                            self.flag = 0
                        }
                        self.flagz=self.flagz + 1
                        
                    }
                    
                    
                    
                    print(roll)
                }
                
                
            }
        } else {
            gyroModeSet = false
            //mqttManager.disconnect()
            motionManager.stopDeviceMotionUpdates()
            
        }
        
        UserDefaults.standard.set(gyroModeSet, forKey: "gyroMode")
        
    }
    
   
   
    @IBAction func setCarSpeed(_ sender: Any) {
       
//            mqttManager = MQTTManager.shared(host: ipAddressField,topic: topic)
//            mqttManager.connect()
         var speed = 0;
        
        
        if carSpeedOptions.selectedSegmentIndex == 0{
            speed = 0
            print("Speed is low")
            self.mqttManager.publish(with: "speed is 5")
        }
        if carSpeedOptions.selectedSegmentIndex == 1 {
            speed = 1
            print("Speed is medium")
            self.mqttManager.publish(with: "speed is 6")
        }
        if carSpeedOptions.selectedSegmentIndex == 2 {
            speed = 2
            print("Speed is high")
            self.mqttManager.publish(with: "speed is 7")
        }
           
        
        
        UserDefaults.standard.set(speed, forKey: "speed")
        
        
        
        
        
       
        
       
    }
    let ipAddressField = "192.168.1.6"
    let topic = "DriveChannel"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mqttManager = MQTTManager.shared(host: ipAddressField,topic: topic)
        mqttManager.connect()
        
        
        
        if let x = UserDefaults.standard.object(forKey: "speed") as? Int {
            carSpeedOptions.selectedSegmentIndex = x
        }
        
        
        if let y = UserDefaults.standard.object(forKey: "gyroMode") as? Bool {
            drivingModeSwitch.isOn = y
        }
        
        
        
        if drivingModeSwitch.isOn {
            mqttManager = MQTTManager.shared(host: ipAddressField,topic: topic)
            mqttManager.connect()
            isFirst  = true;
            flag = 0
            flagz = 0
            var initialAttitude = CMAttitude()
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical, to: OperationQueue.current!){ (motiondata, err) in
                guard let data = motiondata else {return}
                
                if self.isFirst == true {
                    initialAttitude = data.attitude
                    self.isFirst = false
                } else {
                    let attitude = data.attitude
                    attitude.multiply(byInverseOf: initialAttitude)
                    let pitch = self.radiansToDegrees(attitude.pitch)
                    let roll = self.radiansToDegrees(attitude.roll)
                    
                    print(pitch)
                    if pitch < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "3")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if pitch > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "2")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "4")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "1")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    } else if roll < 50 && roll > -50 && pitch < 50 && pitch > -50 {
                        if self.flagz < 1{
                            self.mqttManager.publish(with: "0")
                            self.flag = 0
                        }
                        self.flagz=self.flagz + 1
                        
                    }
                    
                    
                    
                    print(roll)
                }
            
            }
        }
        if drivingModeSwitch.isOn == false {
            //mqttManager.disconnect()
            motionManager.stopGyroUpdates()
        }
    }
        
        
       
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func radiansToDegrees(_ radian: Double) -> Float {
        return Float(radian * 180.0/Double.pi)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if carSpeedOptions.selectedSegmentIndex == 0 {
            self.mqttManager.publish(with: "5")
            
            
        }
        
        if carSpeedOptions.selectedSegmentIndex == 1 {
            self.mqttManager.publish(with: "6")
            
        }
        if carSpeedOptions.selectedSegmentIndex == 2 {
            self.mqttManager.publish(with: "7")
            
        }
       
       
        if drivingModeSwitch.isOn {
            var initialAttitude = CMAttitude()
            motionManager.deviceMotionUpdateInterval = 0.1
            mqttManager = MQTTManager.shared(host: ipAddressField,topic: topic)
            mqttManager.connect()
            isFirst  = true;
            flag = 0
            flagz = 0
            
            motionManager.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xArbitraryZVertical, to: OperationQueue.current!){ (motiondata, err) in
                guard let data = motiondata else {return}
                
                if self.isFirst == true {
                    initialAttitude = data.attitude
                    self.isFirst = false
                } else {
                    let attitude = data.attitude
                    attitude.multiply(byInverseOf: initialAttitude)
                    let pitch = self.radiansToDegrees(attitude.pitch)
                    let roll = self.radiansToDegrees(attitude.roll)
                    
                    print(pitch)
                    if pitch < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "3")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if pitch > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "2")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll < -50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "4")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    }
                    
                    if roll > 50 {
                        if self.flag < 1{
                            self.mqttManager.publish(with: "1")
                            self.flagz=0
                        }
                        self.flag=self.flag+1
                    } else if roll < 50 && roll > -50 && pitch < 50 && pitch > -50 {
                        if self.flagz < 1{
                            self.mqttManager.publish(with: "0")
                            self.flag = 0
                        }
                        self.flagz=self.flagz + 1
                        
                    }
                    
                    
                    
                    print(roll)
                }
            
            
            }
        
        
        } else {
            //mqttManager.disconnect()
            motionManager.stopDeviceMotionUpdates()
        }

}
}
