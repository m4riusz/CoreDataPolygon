import UIKit

class HomeListController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var homes: [Home] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddButton))
        
        tableView.register(UINib(nibName: "SubtitleTableViewCell", bundle: nil), forCellReuseIdentifier: "SubtitleTableViewCell")
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homes = DataProvider.shared.getHomes()
    }
    
    @objc
    func onAddButton() -> Void {
        let alert: UIAlertController = UIAlertController(title: "Add new home", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Street"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "City"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Postal code"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let street: String? = alert.textFields![0].text
            let city: String? = alert.textFields![1].text
            let postal: String? = alert.textFields![2].text
            self.homes.insert(DataProvider.shared.addNewHome(withStreet: street, withCity: city, withPostal: postal), at: 0)
            alert.dismiss(animated: true, completion: nil)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


extension HomeListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SubtitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SubtitleTableViewCell") as! SubtitleTableViewCell
        let home: Home = homes[indexPath.row]
        let street: String = home.street ?? ""
        let city: String = home.city ?? ""
        let postal: String = home.postal ?? ""
        cell.textLabel?.text = "Street: \(street)"
        cell.detailTextLabel?.text = "\(city) \(postal)"
        return cell
    }
    
}
