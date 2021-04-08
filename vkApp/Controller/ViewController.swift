//
//  ViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 05.04.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logintTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func buttonTapped(_ sender: Any) {
        if (logintTextfield.text == "admin") && (passwordTextField.text == "admin") {
            print("Осуществлён вход с учётной записи администратора!")
        } else {
            print("В доступе отказано!")
        }
    }
}
