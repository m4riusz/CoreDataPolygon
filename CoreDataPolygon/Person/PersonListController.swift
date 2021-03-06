import UIKit

class PersonListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButton))
        
        tableView.register(UINib(nibName: "SubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SubtitleTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataProvider.shared.personsGetWithPredicate(withSuccessCallback: { (persons) in
            self.persons = persons
            self.tableView.reloadData()
        }) { (error) in
            NSLog(error.localizedDescription)
        }
    }
    
    @objc
    func onAddButton() -> Void {
        let alert: UIAlertController = UIAlertController(title: "Add new home", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "First name"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Last name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let firstName: String = alert.textFields![0].text ?? ""
            let lastName: String = alert.textFields![1].text ?? ""
            let createDate: Date = Date()
            DataProvider.shared.personsAddNew(withFirstName: firstName, withLastName: lastName, withCreateDate: createDate, withSuccessCallback: { (person) in
                self.persons.insert(person, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            }, withErrorCallback: { (error) in
                   NSLog(error.localizedDescription)
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


extension PersonListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubtitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SubtitleTableViewCell", for: indexPath) as! SubtitleTableViewCell
        let person: Person = persons[indexPath.row]
        let firstName: String = person.firstName ?? ""
        let lastName: String = person.lastName ?? ""
        let createDate: Date = (person.createDate ?? NSDate()) as Date
        cell.textLabel?.text = "\(firstName) \(lastName)"
        cell.detailTextLabel?.text = createDate.description
        return cell
    }
    
}

extension PersonListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
