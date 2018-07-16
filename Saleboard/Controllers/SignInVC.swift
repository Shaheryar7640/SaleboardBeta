//
//  SignInVC.swift
//  Saleboard
//
//  Created by Office User on 7/16/18.
//  Copyright © 2018 FlairPitPvt. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    //MARK: - Connected Variables

    @IBOutlet weak var logoImageView: DesignableImage!
    
    @IBOutlet weak var emailTextField: DesignableUITextField!
    
    @IBOutlet weak var passWordTextField: DesignableUITextField!
    
    @IBOutlet weak var loginButton: DesignableButton!
    
    @IBOutlet weak var faceBookButton: DesignableButton!
    @IBOutlet weak var gmailButton: DesignableButton!
    @IBOutlet weak var forgetPasswordLabel: UILabel!
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    
    //MARK: - Connected Functions

    @IBAction func didTapSignInWithFacebook(_ sender: Any) {
    }
    
    @IBAction func didTapSignInWithGmail(_ sender: Any) {
    }
    
    @IBAction func didTapResgisterNowButton(_ sender: Any) {
    }
    
    @IBAction func didTapLoginButton(_ sender: Any) {
    }
    
    

}

extension SignInVC{
    
    func setupUI(){
       
        logoImageView.layer.cornerRadius = logoImageView.bounds.size.height/2
        faceBookButton.layer.cornerRadius = faceBookButton.frame.height/2
        faceBookButton.layer.masksToBounds = true
        gmailButton.layer.cornerRadius = gmailButton.frame.height/2
        gmailButton.layer.masksToBounds = true
        
        
    }
    
    
}
