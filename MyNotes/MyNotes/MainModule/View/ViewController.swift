//
//  ViewController.swift
//  MyNotes
//
//  Created by Халим Магомедов on 12.03.2022.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Мои заметки"
        let barButtonItem = UIBarButtonItem(image: .add, landscapeImagePhone: .add, style: .plain, target: self, action: #selector(showAlert))
        self.navigationItem.rightBarButtonItem = barButtonItem
        setupSubviewes()
//        deleteNote()
    }
    
    private func setupSubviewes() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.bottom.top.leading.trailing.equalToSuperview()
        }
    }
    
    @objc func showAlert (){
        let alertController = UIAlertController(title: "Новая заметка", message: "Введите заметку", preferredStyle: .alert)
        
        alertController.addAction (UIAlertAction(title: "Сохранить", style: .default) { [weak self] action in
            let tf = alertController.textFields?.first
            if let newNote = tf?.text, tf?.text != "" {
                self?.saveTask(withTitle: newNote)
                self?.tableView.reloadData()
            }
        })
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addTextField { _ in }
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let context = getContext()
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func saveTask(withTitle title: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else {return}
        let noteObject = Note(entity: entity, insertInto: context)
        noteObject.title = title
        
        do {
            try context.save()
            notes.append(noteObject)
        } catch let error as NSError {
            print (error.localizedDescription)
        }
    }
    
    func deleteNote(){
        let context = getContext()
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                context.delete(object)
            }
        }
        do {
            try context.save()
            self.tableView.reloadData()

            
        } catch let error as NSError {
            print (error.localizedDescription)
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

extension  ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive,
                                       title: "DeleteAll") { [weak self] (action, view, completionHandler) in
        self?.deleteNote()
        }
        delete.backgroundColor = .systemRed
        return  UISwipeActionsConfiguration(actions: [delete])
        }
    }
    
    
    extension ViewController:  UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return notes.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
            let note = notes[indexPath.row]
            cell.textLabel?.text = note.title
            return cell
        }
        
    }

