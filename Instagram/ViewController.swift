//
//  ViewController.swift
//  Instagram
//
//  Created by Wadee Sami on 1/14/18.
//  Copyright © 2018 Wadee AbuZant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let plusButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let emailTextField :UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.borderStyle = .roundedRect
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let usernameTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Username"
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let passwordTextField :UITextField = {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.backgroundColor = UIColor(white: 0, alpha: 0.03)
        textfield.font = UIFont.systemFont(ofSize: 14)
        return textfield
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor(displayP3Red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        view.addSubview(plusButton)
        plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, usernameTextField, passwordTextField, signupButton])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = UIColor.green
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 20.0),
            stackView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: -40.0),
            stackView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: 40.0),
            stackView.heightAnchor.constraint(equalToConstant: 200)
            ])

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

