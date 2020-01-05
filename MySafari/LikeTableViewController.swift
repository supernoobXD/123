
import UIKit

class LikeTableViewController: UITableViewController {

    var dataArray:Array<String>?
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = UserDefaults.standard.value(forKey: "Like") as! Array<String>?
        if dataArray==nil {
            dataArray = []
        }
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataArray?.remove(at: indexPath.row)
            UserDefaults.standard.set(dataArray!, forKey: "Like")
            UserDefaults.standard.synchronize()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell==nil {
            cell=UITableViewCell(style: .default, reuseIdentifier: "cellID")
        }
        cell?.textLabel?.text = dataArray![indexPath.row]
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self.navigationController?.viewControllers.first as! ViewController).loadURL(urlStr: dataArray![indexPath.row])
        self.navigationController!.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isToolbarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isToolbarHidden = false
    }

}
