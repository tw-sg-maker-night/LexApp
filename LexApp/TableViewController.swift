import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    var conversationTypes: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.conversationTypes = ["Voice", "Chat"]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversationTypes!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel?.text = self.conversationTypes![indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "voicecontroller", sender: self)
        }
        else {
            self.performSegue(withIdentifier: "chatcontroller", sender: self)
        }
    }
}
