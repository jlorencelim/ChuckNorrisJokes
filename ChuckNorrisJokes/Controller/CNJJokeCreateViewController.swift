//
//  CNJJokeCreateViewController.swift
//  ChuckNorrisJokes
//
//  Created by Lorence Lim on 22/09/2017.
//  Copyright © 2017 Lorence Lim. All rights reserved.
//

import CoreData
import UIKit

class CNJJokeCreateViewController: UIViewController {

    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveJoke(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = CNJJokeManagedObject.fetchRequest()

        do {
            let result = try context.fetch(fetchRequest)
            let jokeManagedObject = CNJJokeManagedObject(context: context)
            jokeManagedObject.id = Int32(result.count)
            jokeManagedObject.content = contentTextView.text
            
            self.navigationController?.popViewController(animated: true)
        }
        catch {
            let fetchError = error as NSError
            print (fetchError)
        }
    }
}
