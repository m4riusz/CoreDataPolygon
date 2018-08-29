import UIKit

class HomeDetailController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var persons: [Person] = []
    
    var home: Home?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onClose))
        
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
    func onClose() -> Void {
        dismiss(animated: true, completion: nil)
    }
}


extension HomeDetailController: UITableViewDataSource {
    
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
        cell.accessoryType = (home?.persons?.contains(person))! ? .checkmark : .none
        return cell
    }
    
}

extension HomeDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item: Person = persons[indexPath.row]
        item.home = item.home != nil && item.home == home ? nil : home
        
        DataProvider.shared.personsUpdatePerson(item, withSuccessCallback: { (person) in
            tableView.reloadRows(at: [indexPath], with: .fade)
        }) { (error) in
            NSLog(error.localizedDescription)
        }
    }
}

