//
//  loginController.swift
//  MySafari
//
//  Created by sdp on 2020/1/5.
//  Copyright © 2020 jaki. All rights reserved.
//

import UIKit

let defaultStand = UserDefaults.standard


class loginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
       // defaultStand.set(123, forKey: defaultKey)
        //defaultStand.integer(forKey: defaultKey)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btn(_ sender: Any) {
        struct AccountInfo {
            var user = "abc"
            var password = "123"
        }
        if (self.userName.text! == AccountInfo().user && self.userPsd.text! ==  AccountInfo().password){
            self.performSegue(withIdentifier: "change", sender: self)
        }else{
            print("密码错误")
        }
        
    }
    
    
    @IBOutlet weak var userPsd: UITextField!
    @IBOutlet weak var userName: UITextField!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
