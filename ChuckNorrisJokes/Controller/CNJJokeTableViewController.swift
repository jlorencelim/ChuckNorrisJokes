//
//  CNJJokeTableViewController.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 18/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//

import CoreData
import UIKit

class CNJJokeTableViewController: UITableViewController {
    
    enum JSONError: String, Error {
        case NoData = "Error: no data"
        case ConversionField = "Error: conversion from JSON failed"
    }
    var jokes:NSArray = []
    var jokesCoreData = [CNJJokeManagedObject]()
    var selectedManagedObject:CNJJokeManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 44;
        
        fetchJokes(completion: loadData)
        loadFromCoreData()
        fetchJokes(completion: saveToCoreData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFromCoreData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.jokesCoreData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CNJJokeTableViewCell", for: indexPath) as! CNJJokeTableViewCell
        
        let jokeManagedObject = self.jokesCoreData[indexPath.row]
        cell.configure(managedObject: jokeManagedObject)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "CNJJokeDetailViewSegue") {
            let controller:CNJJokeDetailViewController = segue.destination as! CNJJokeDetailViewController
            controller.managedObject = self.selectedManagedObject
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedManagedObject = self.jokesCoreData[indexPath.row]
        performSegue(withIdentifier: "CNJJokeDetailViewSegue", sender: self)
    }
    
    func fetchJokes(completion:((NSDictionary) -> Void)!) {
        let url = URL(string: "http://api.icndb.com/jokes/random/20")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionField
                }
                completion(json)
            }
            catch let error as JSONError {
                print (error.rawValue)
            }
            catch let error as NSError {
                print (error.debugDescription)
            }
        }
        task.resume()
    }
    
    func loadData(jsonData:NSDictionary) {
        self.jokes = jsonData["value"] as! NSArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func saveToCoreData(jsonData:NSDictionary) {
        DispatchQueue.main.async {
            let jsonJokes = jsonData["value"] as! NSArray
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            for (index, joke) in jsonJokes.enumerated() {
                let joke = joke as! NSDictionary
                let jokeManagedObject = CNJJokeManagedObject(context: context)
                jokeManagedObject.id = Int32(index)
                jokeManagedObject.content = joke["joke"] as! String
                self.jokesCoreData.append(jokeManagedObject)
            }
            
            self.loadFromCoreData()
        }
    }
    
    func loadFromCoreData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = CNJJokeManagedObject.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try context.fetch(fetchRequest)
            let resultArray = result as! [CNJJokeManagedObject]
            self.jokesCoreData = resultArray
        }
        catch {
            let fetchError = error as NSError
            print (fetchError)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
