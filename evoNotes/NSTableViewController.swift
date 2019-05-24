//
//  NSTableViewController.swift
//  evoNotes
//
//  Created by Nikita Kalyuzhnii on 5/17/19.
//  Copyright © 2019 Nikita Kalyuzhniy. All rights reserved.
//

import UIKit

class NSTableViewController: UITableViewController,NoteViewDelegate {

    var notes = [[String:String]]()
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.readNotes()
        
    }
    
    func saveNotes() {
        UserDefaults.standard.set(self.notes, forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
    func readNotes() {
        if let newNotes = UserDefaults.standard.array(forKey: "notes") as? [[String:String]]{
            
            self.notes = newNotes
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)

    }
    
    // MARK: - Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveNotes()
        }
    }
    
    
    @IBAction func addNote(_ sender: Any) {
        let note = ["title" : "" , "body" : ""]
        notes.insert(note, at: 0)
        self.selectedIndex = 0
        performSegue(withIdentifier: "ShowEditScreenSegue", sender: nil)
        self.tableView.reloadData()
    }
    
    func didUpdateNote(updatedTitle: String, updatedBody: String) {
        self.notes[selectedIndex]["title"] = updatedTitle
        self.notes[selectedIndex]["body"] = updatedBody
        self.tableView.reloadData()
        self.saveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.notes[indexPath.row]["title"]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let notesEditorVC = segue.destination as? NewNoteViewController
        notesEditorVC?.title = self.notes[selectedIndex]["title"]
        notesEditorVC?.strBodyText = self.notes[selectedIndex]["body"]
        notesEditorVC?.noteViewDelegate = self

    }
 
}
