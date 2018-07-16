//
//  SignUpAskForEmailPassword.swift
//  Saleboard
//
//  Created by Office User on 7/16/18.
//  Copyright © 2018 FlairPitPvt. All rights reserved.
//

import UIKit
import CTKFlagPhoneNumber

class SignUpAskForEmailPassword: UIViewController {

    @IBOutlet weak var emailTextField: DesignableUITextField!
    
    @IBOutlet weak var passwordTextField: DesignableUITextField!
    @IBOutlet weak var nextButton: DesignableButton!
    @IBOutlet weak var showPasswordButton: UIButton!
    
    @IBOutlet weak var emailPhoneToggleBtn: UIButton!
    @IBOutlet weak var facebookButton: DesignableButton!
    @IBOutlet weak var gmailButton: DesignableButton!
    
    var phoneNumberTextField: CTKFlagPhoneNumberTextField!
    var isActiveForEmail:Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

   
    
    @IBAction func didTapNextButton(_ sender: Any) {
    }
    
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapShowPassword(_ sender: Any) {
    }
    
    
    @IBAction func didTapEmailPhoneToggleButton(_ sender: Any) {
        
        if isActiveForEmail{
            
            emailTextField.resignFirstResponder()
            phoneNumberTextField.isHidden = false
            emailTextField.isHidden = true
            emailPhoneToggleBtn.setTitle("Email", for: .normal)
            isActiveForEmail = false
            if (phoneNumberTextField.text?.count)! > 9{
                nextButton.backgroundColor = .purple
                nextButton.isEnabled = true
                
            }else{
                nextButton.backgroundColor = .darkGray
                nextButton.isEnabled = false
            }
            emailTextField.resignFirstResponder()
            
            
        }else{
            
            setupForEmailField()
            
        }
        
        
    }
    
    

}
extension SignUpAskForEmailPassword{
    
    func setupUI(){
        
        facebookButton.layer.cornerRadius = facebookButton.frame.height/2
        facebookButton.clipsToBounds = true
        gmailButton.layer.cornerRadius = facebookButton.frame.height/2
        gmailButton.clipsToBounds = true
        setupForPhoneNumberTextField()
        setupForEmailField()
//        phoneNumberTextField.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.hideKeyboardWhenTappedAround()
        nextButton.backgroundColor = UIColor.darkGray
        phoneNumberTextField.keyboardType = .phonePad
        
        
    }
    
    
    func setupForPhoneNumberTextField(){
        
        
        let frm:CGRect = emailTextField.frame
        
        phoneNumberTextField = CTKFlagPhoneNumberTextField(frame: CGRect(x: frm.origin.x, y: frm.origin.y, width: emailTextField.frame.width, height: emailTextField.frame.height))
        phoneNumberTextField.flagSize = CGSize(width: frm.origin.x + 10, height: phoneNumberTextField.frame.height - 16)
        phoneNumberTextField.flagButtonEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10)
        phoneNumberTextField.parentViewController = self
        phoneNumberTextField.setFlag(with: "PK")
        
        view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.isHidden = true
        phoneNumberTextField.keyboardType = .namePhonePad
        
        
    }
    
    func setupForEmailField(){
        
        nextButton.backgroundColor = .darkGray
        nextButton.isEnabled = false
        phoneNumberTextField.resignFirstResponder()
        emailTextField.isHidden = false
        phoneNumberTextField.isHidden = true
        emailPhoneToggleBtn.setTitle( "Phone Number", for: .normal)
        emailTextField.keyboardType = .emailAddress
        if emailTextField.text != "" && emailTextField.text != " "{
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple
        }
        
        isActiveForEmail = true
        
    }
    
    
}
