//
//  SettingsViewController.swift
//  VRCarApp
//
//  Created by Pallak Singh on 17/11/18.
//  Copyright © 2018 Pallak Singh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var carSpeedOptions: UISegmentedControl!
    
    @IBAction func setCarSpeed(_ sender: Any) {
        switch carSpeedOptions.selectedSegmentIndex{
        case 0:
            print("Speed is low")
        case 1:
            print("Speed is medium")
        case 2:
            print("Speed is high")
        default:
            break
            
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
