//
//  ViewController.swift
//  ID
//
//  Created by takusan23 on 2019/06/09.
//  Copyright © 2019 takusan23. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var isLogin = false // 認証状態
    let userDefaults = UserDefaults.standard // データ保存
    @IBOutlet weak var Label: UILabel! // 表示するLabel
    @IBOutlet weak var TextField: UITextField! // テキストボックス
    // 認証ボタン
    @IBAction func LoginButtonTouchDown(_ sender: Any) {
        startLogin()
    }
    
    @IBAction func TextSaveButtonTouchDown(_ sender: UIButton) {
        if isLogin {
            userDefaults.set(TextField.text!, forKey: "text")
            Label.text = self.userDefaults.string(forKey: "text")
        } else {
            startLogin()
        }
    }
    func startLogin(){
        let context = LAContext()
        var error : NSError?
        let description : String = "認証"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: description, reply: {success,evaliateError in
                DispatchQueue.main.async {
                    if success {
                        // 存在するか
                        if self.userDefaults.object(forKey: "text") != nil {
                            // 存在した
                            self.Label.text = self.userDefaults.string(forKey: "text")
                        } else {
                            // ない
                            self.Label.text = "未設定です"
                        }
                        self.isLogin = true
                    }else{
                        self.Label.text = "認証できませんでした"
                    }
                }
            })
        }else{
            Label.text = "生体認証が利用できません"
        }
    }
}

