//
//  ViewController.swift
//  webinar 2
//
//  Created by Дмитрий Паркалов on 7.02.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let fromLoginToTabBarSegue = "fromLoginToTabBarSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        
        guard let keyboardHeight = keyboardSize?.height else {return}
        
        let contentInsent = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        scrollView.contentInset = contentInsent
        scrollView.scrollIndicatorInsets = contentInsent
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc func onTap() {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = self.loginTextField.text,
              login == "login",
              let password = self.passwordTextField.text,
              password == "55555"
        else {
            print("error")
            return
        }
    
        performSegue(withIdentifier: fromLoginToTabBarSegue, sender: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
