//
//  ViewController.swift
//  MyTodo
//
//  Created by Ipan Ardian on 4/28/16.
//  Copyright © 2016 Ipan Ardian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    var item = Item(name: "")

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let item = item {
            nameTextField.text = item.name
        }
        
        nameTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Hide keyboard
        nameTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as AnyObject? {
            let name = nameTextField.text ?? ""
            item = Item(name: name)

        }
    }
    
    // MARK: Actions
    
    @IBAction func cancelAddItem(_ sender: UIBarButtonItem) {
        let isInAddModule = presentingViewController is UINavigationController
        
        if isInAddModule {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}

