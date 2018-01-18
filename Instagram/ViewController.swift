//
//  ViewController.swift
//  Instagram
//
//  Created by Wadee Sami on 1/14/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let plusButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(addProfileButton), for: .touchUpInside)
        return btn
    }()
    
    let emailTextField :UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textfield
    }()
    
    let usernameTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Username"
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textfield
    }()
    
    let passwordTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        return textfield
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 148, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(plusButton)
        plusButton.anchor(top: view.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 20, paddingleft: 0, paddingRight: 0, paddingBottom: 0, width: 140, height: 140)
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        
        stackView.backgroundColor = UIColor.green
        view.addSubview(stackView)
        stackView.anchor(top: plusButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, bottom: nil, paddingTop: 20, paddingleft: 40, paddingRight: -40, paddingBottom: 0, width: 0, height: 200)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleSignup(){
        let email = emailTextField.text
        let password = passwordTextField.text
        
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
            if error != nil{
                print ("Couldn't create a user !!\(error.debugDescription)")
                
            }
            
            //upload profile image
            guard let image = self.plusButton.imageView?.image else {return}
            let imageName = NSUUID().uuidString
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            Storage.storage().reference().child("profile_image").child(imageName).putData(imageData!, metadata: nil){(metadata, error) in
                guard let metaData = metadata else {return}
                let url = metaData.downloadURL()?.absoluteString
                
                let nameMap = ["username": self.usernameTextField.text!, "profile_image":url]
                guard let uid = user?.uid else {return}
                Database.database().reference().child("users").updateChildValues([uid:nameMap], withCompletionBlock: {(err, ref) in
                    if let err = err {
                        print("couldnt sign up !!\(err.localizedDescription)")
                        return
                    }
                    print("User saved to db successfully")
                })
            }
            
            
            
        })
    }
    
    @objc func handleTextChange(){
        let formValid = !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && !(usernameTextField.text?.isEmpty)!
        
        if formValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }else{
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        }
    }
    
    @objc func addProfileButton(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        plusButton.layer.cornerRadius = plusButton.frame.width/2
        plusButton.layer.borderColor = UIColor.black.cgColor
        plusButton.layer.borderWidth = 3.0
        plusButton.clipsToBounds = true
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            plusButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

