//
//  ManageViewController.swift
//  LoosenUP
//
//  Created by 黃麒安 on 2017/3/6.
//  Copyright © 2017年 黃麒安. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn

class ManageViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var view_AccountManage: UIView!
    @IBOutlet weak var view_personalManage: UIView!
    @IBOutlet weak var view_logout: UIView!
    @IBOutlet weak var btn_FBLogin: UIButton!
    @IBOutlet weak var btn_GoogleLogin: UIButton!
    @IBOutlet weak var lb_userName: UILabel!{
        didSet{
            lb_userName.layer.cornerRadius = 15
            lb_userName.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var lb_GoogleUser: UILabel!{
        didSet{
            lb_GoogleUser.layer.cornerRadius = 15
            lb_GoogleUser.layer.masksToBounds = true
        }
    }
    
    private var firstName = ""
    private var lastName = ""
    let group = DispatchGroup()
    var isWaitForGoogleLogin = false
    var isWaitForFBLogin = false
    
    @IBAction func facebookCustomLogIn(_ sender: UIButton) {
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        // Your Custom Permissions Array
        loginButton.permissions = ["public_profile","email"]
        // Hiding the button
        loginButton.isHidden = true
        self.view.addSubview(loginButton)
        // Simulating a tap for the actual Facebook SDK button
        loginButton.sendActions(for: UIControl.Event.touchUpInside)
        
        if((AccessToken.current?.userID) == nil){
            //login
            group.enter()
            self.isWaitForFBLogin = true
        }
        
        group.notify(queue: .main) {
            if (UserDefaults.standard.object(forKey: "FBUserName") as! String) != ""{
                self.lb_userName.text = (UserDefaults.standard.object(forKey: "FBUserName") as! String)
                self.isWaitForFBLogin = false
            }else{
                UserDefaults.standard.set("", forKey: "FBUserName")
                self.lb_userName.text = "未連結"
                self.isWaitForFBLogin = false
            }
            
        }
    }
    
    @IBAction func googleCustomLogin(_ sender: Any) {
        let loginButton = GIDSignInButton()
        loginButton.isHidden = true
        self.view.addSubview(loginButton)
        
        if GIDSignIn.sharedInstance()?.currentUser != nil{
            print("have login")
            GIDSignIn.sharedInstance().signOut()
            lb_GoogleUser.text = "未連結"
        }else{
            print("haven't login")
            group.enter()
            DispatchQueue.main.async {
                loginButton.sendActions(for: .touchUpInside)
                self.isWaitForGoogleLogin = true
            }
            group.notify(queue: .main) {
                self.lb_GoogleUser.text = (UserDefaults.standard.object(forKey: "GoogleUserName") as! String)
                self.isWaitForGoogleLogin = false
            }
        }
    }
    
    
    static let shared = ManageViewController()
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if GIDSignIn.sharedInstance()?.currentUser != nil{
            print("have login")
            lb_GoogleUser.text = (UserDefaults.standard.object(forKey: "GoogleUserName") as! String)
        }else{
            print("haven't login")
            lb_GoogleUser.text = "未連結"
        }
        
        //-------fb login--------
        if ((AccessToken.current?.userID) != nil) {
            //user is login
            lb_userName.text = (UserDefaults.standard.object(forKey: "FBUserName") as! String)
        }else{
            lb_userName.text = "未連結"
        }
        //-----------------------
        Setting.shared.addObserver(self, forKeyPath: "themeType", options: .new, context: nil)
        
        UINavigationService.setNavBarColor(navigationController: self.navigationController!, color: Setting.shared.mainColor())
        UINavigationService.setedgefor_navigationbar(viewcontroller: self)
        
        let swipe_left = UISwipeGestureRecognizer(target: self, action: #selector(ManageViewController.swipe_tabs_left))
        swipe_left.direction = .left
        self.view.addGestureRecognizer(swipe_left)
        
        let swipe_right = UISwipeGestureRecognizer(target: self, action: #selector(ManageViewController.swipe_tabs_right))
        swipe_right.direction = .right
        self.view.addGestureRecognizer(swipe_right)
        
        
        let tap_account = UITapGestureRecognizer(target: self, action: #selector(self.toAccountManage))
        self.view_AccountManage.addGestureRecognizer(tap_account)
        
        let tap_personalmanage = UITapGestureRecognizer(target: self, action: #selector(self.toPersonalManage))
        self.view_personalManage.addGestureRecognizer(tap_personalmanage)
        
        let tap_logout = UITapGestureRecognizer(target: self, action: #selector(self.logout))
        self.view_logout.addGestureRecognizer(tap_logout)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func toAccountManage(){
        print("to account manage")
        
        let viewcontroller = AccountManageViewController()
        viewcontroller.title = NSLocalizedString("AccountManageViewController.title", comment: "")
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func toPersonalManage(){
        print("to personal manage")
        
        let viewcontroller = PersonalManageViewController()
        viewcontroller.title = NSLocalizedString("PersonalManageViewController.title", comment: "")
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func logout(){
        print("logout")
    }

    @objc func swipe_tabs_left(){
        print("left")
        HomeTabBarController.shared.swipe_tabs_left()
    }
    
    @objc func swipe_tabs_right(){
        print("right")
        HomeTabBarController.shared.swipe_tabs_right()
    }
}

extension ManageViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        self.lb_userName.text = "未連結"
    }
    
    func fetchProfile(){
        print("attempt to fetch profile......")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        
        GraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: {
            connection, result, error -> Void in
            
            if error != nil {
                print("登入失敗")
                print("longinerror =\(String(describing: error))")
            } else {
                
                if let resultNew = result as? [String:Any]{
                    
                    print("成功登入")
                    
                    let userDefault = UserDefaults.standard
                    let fullName = (resultNew["last_name"] as! String) + (resultNew["first_name"] as! String)
                    let email = resultNew["email"]  as! String
                    userDefault.set(fullName, forKey: "FBUserName")
                    userDefault.set(email, forKey: "FBUserEmail")
                    if let picture = resultNew["picture"] as? NSDictionary,
                        let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String {
                        print(url) //臉書大頭貼的url, 再放入imageView內秀出來
                        userDefault.set(url, forKey: "FBAvatar")
                    }
                }
            }
            
            if self.isWaitForFBLogin{
                self.group.leave()
            }
        })
    }
}

extension ManageViewController {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath! == "themeType"{
            self.navigationController?.navigationBar.barTintColor = Setting.shared.mainColor()
        }
        
    }
    
}
