//
//  ViewController.swift
//  googleSignInSample
//
//  Created by Cogniti Digital on 25/02/19.
//  Copyright © 2019 Cogniti Digital. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FBSDKLoginKit
import FacebookCore


class ViewController: UIViewController, GIDSignInUIDelegate {

     var dict : [String : AnyObject]!
    @IBOutlet weak var signIn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         GIDSignIn.sharedInstance().uiDelegate = self
        
    }
    
 
    @IBAction func btnGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func btnFb(_ sender: Any) {
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["public_profile"], from: self, handler: { result, error in
            if error != nil {
                print("Process error")
            } else if result?.isCancelled != nil {
                print("Cancelled")
            } else {
                print("Logged in")
            }
        })
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as? [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }
    
  
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
