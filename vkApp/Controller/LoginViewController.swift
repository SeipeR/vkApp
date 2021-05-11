//
//  ViewController.swift
//  vkApp
//
//  Created by Дамир Доронкин on 05.04.2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loadingView1: UIView!
    @IBOutlet weak var loadingView2: UIView!
    @IBOutlet weak var loadingView3: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var logintTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func buttonTapped(_ sender: Any) {
        guard checkUserInfo() else {
            return
        }
        
        let myTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyTabBarController")
        myTabBarController.transitioningDelegate = self
        present(myTabBarController, animated: true)
    }
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLoadingIndicator()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        // Уведомление при появлении клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // Уведомление при скрытии клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    func createLoadingIndicator() {
        loadingView1.layer.cornerRadius = loadingView1.frame.width / 2
        loadingView2.layer.cornerRadius = loadingView2.frame.width / 2
        loadingView3.layer.cornerRadius = loadingView3.frame.width / 2
        
        UIView.animate(withDuration: 1, delay: 0, options: .repeat) {
            self.loadingView1.alpha = 0
        }
        UIView.animate(withDuration: 1, delay: 0.25, options: .repeat) {
            self.loadingView2.alpha = 0
        }
        UIView.animate(withDuration: 1, delay: 0.5, options: .repeat) {
            self.loadingView3.alpha = 0
        }
    }
    
    private func checkUserInfo() -> Bool {
        guard
            let username = logintTextfield.text,
            let password = passwordTextField.text,
            username == "",
            password == ""
        else {
            presentError()
            return false
        }
        
        return true
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        guard identifier == "goInside" else {
//            return false
//        }
//
//        return checkUserInfo()
//    }
    
    private func presentError(with message: String = "Неправильный логин или пароль!") {
        let alertController = UIAlertController(title: "Ошибка!",
                                                message: message,
                                                preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok",
                                     style: .default) { _ in
            self.logintTextfield.text = ""
            self.passwordTextField.text = ""
        }
        alertController.addAction(okButton)
        present(alertController,
                animated: true)
    }
        
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        // Размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляется отступ ниже UIScrollView, равный размеру клавиатуры
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // При исчезновении клавиатуры, отступ ниже UIScrollView становится равен 0
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
}

class LoginButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
}

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LoginViewControllerPresentAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        LoginViewControllerDismissAnimator()
    }
}
