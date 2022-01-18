//
//  ChatViewController.swift
//  TestChat
//
//  Created by Dmytro on 05.01.2022.
//

import UIKit
import Firebase
import NotificationCenter

class ChatViewController: UIViewController  {
    
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageView: UIView!
    
    let db = Firestore.firestore()
    
    
    var messages: [Message] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        navigationItem.hidesBackButton = true
        
        title = Constants.titleLabel
        
        initializeHideKeyboard()
        
    }
    
    
    func loadMessage() {
        
        
        db.collection(Constants.FireStore.collectionName)
            .order(by: Constants.FireStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.messages = []
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let newSender = data[Constants.FireStore.senderField] as? String, let newMessage = data[Constants.FireStore.bodyField] as? String {
                                
                                let newMessage = Message(sender: newSender, body: newMessage)
                                
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                                }
                                
                            }
                            
                            
                            
                            
                       }
                    }
                }
        
    }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FireStore.collectionName).addDocument(data: [
                Constants.FireStore.senderField : messageSender,
                Constants.FireStore.bodyField : messageBody,
                Constants.FireStore.dateField : Date().timeIntervalSince1970
            ]) { error in
                if let e = error {
                    print(e)
                } else {
                    print("Successfully")
                    DispatchQueue.main.async {
                        self.messageTextField.text?.removeAll()
                    }
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! NewMessageCell
        cell.textMessageLabel.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            cell.youLabel.isHidden = true
            cell.meLabel.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.textMessageLabel.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            cell.youLabel.isHidden = false
            cell.meLabel.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.textMessageLabel.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        

        return cell
    }
    
    func initializeHideKeyboard(){
     //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(
     target: self,
     action: #selector(dismissMyKeyboard))
     //Add this tap gesture recognizer to the parent view
     view.addGestureRecognizer(tap)
     }
    
     @objc func dismissMyKeyboard(){
     //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
     //In short- Dismiss the active keyboard.
     view.endEditing(true)
     }
}


// MARK: - NsNotification
extension ChatViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                tableView.contentInset = UIEdgeInsets(top: keyboardSize.height + tableView.rowHeight , left: 0, bottom: 0, right: 0)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            tableView.contentInset = .zero
        }
    }
}

