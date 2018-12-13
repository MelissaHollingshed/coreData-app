//
//  NotesViewController.swift
//  CoreDataApplication
//
//  Created by Melissa Hollingshed on 12/12/18.
//  Copyright © 2018 Melissa Hollingshed. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {

    @IBOutlet weak var notesTableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        notesTableView.dataSource = self
        notesTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(request)
            notesTableView.reloadData()
        } catch {
            print("Failed to fetch notes")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? NoteSingleViewController, let selectedRow = notesTableView.indexPathForSelectedRow?.row {
            destination.existingNote = notes[selectedRow]
        }
    }
    
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        //Customize cell here
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        cell.detailTextLabel?.text = formatter.string(from: note.modificationDate)
        
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showSingleNoteView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completion in
            let note = self.notes[indexPath.row]
            do {
                note.managedObjectContext?.delete(note)
                try note.managedObjectContext?.save()
                self.notes.remove(at: indexPath.row)
                self.notesTableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            } catch {
                print("Failed to delete note")
                completion(false)
            }
        })
        return UISwipeActionsConfiguration(actions: [action])
    }


}

