//
//  NewNoteViewController.swift
//  evoNotes
//
//  Created by Nikita Kalyuzhnii on 5/18/19.
//  Copyright © 2019 Nikita Kalyuzhniy. All rights reserved.
//

import UIKit
import Foundation

protocol NoteViewDelegate {
    func didUpdateNote(updatedTitle : String , updatedBody : String)
    
}

class NewNoteViewController: UIViewController , UITextViewDelegate {
    
    
    @IBOutlet weak var btnSave: UIBarButtonItem!
    @IBOutlet weak var txtBody: UITextView!
    var noteViewDelegate: NoteViewDelegate?
    
    var strBodyText : String!
    var delegate : NoteViewDelegate?

    
    func getNotesTitle() -> String{
        let compotents = self.txtBody.text.components(separatedBy: "\n")
        
        for component in compotents {
            if component.trimmingCharacters(in: CharacterSet.whitespaces).count > 0{
                return component
            }
            
        }
        return self.navigationItem.title ?? ""
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtBody.delegate = self
        self.txtBody.becomeFirstResponder()
        self.txtBody.text = self.strBodyText
        
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.noteViewDelegate != nil{
            self.noteViewDelegate?.didUpdateNote(updatedTitle: getNotesTitle(), updatedBody: self.txtBody.text)
        }

    }
    
    
    @IBAction func saveEdit(_ sender: Any) {
        
        self.txtBody.resignFirstResponder()
        self.btnSave.tintColor = UIColor.clear
    }

}
