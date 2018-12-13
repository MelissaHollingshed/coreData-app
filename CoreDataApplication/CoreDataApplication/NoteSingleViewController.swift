//
//  NoteSingleViewController.swift
//  CoreDataApplication
//
//  Created by Melissa Hollingshed on 12/12/18.
//  Copyright © 2018 Melissa Hollingshed. All rights reserved.
//

import UIKit

class NoteSingleViewController: UIViewController {

    @IBOutlet weak var noteNameTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    var existingNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        noteContentTextView.layer.cornerRadius = 5
        noteContentTextView.layer.borderWidth = 1
        noteContentTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        if let existingNote = existingNote {
            noteNameTextField.text = existingNote.title
            noteContentTextView.text = existingNote.content
        }
    }
    
    @IBAction func saveNote(_ sender: Any) {
        guard let title = noteNameTextField.text else {
            return
        }
        var note: Note?
        if let existingNote = existingNote {
            note = existingNote
            note?.title = title
            note?.content = noteContentTextView.text
            note?.rawModificationDate = Date() as NSDate
        } else {
            note = Note(title: title, content: noteContentTextView.text, modificationDate: Date())
        }
        do {
            try note?.managedObjectContext?.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("Failed to save note")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        noteNameTextField.resignFirstResponder()
        noteContentTextView.resignFirstResponder()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
