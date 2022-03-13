//
//  WishListViewController.swift
//  BuyIN
//
//  Created by apple on 3/12/22.
//

import UIKit

class WishListViewController: UIViewController {

    @IBOutlet weak var wishListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "WishListTableViewCell", bundle: nil)
        wishListTableView.register(nib1, forCellReuseIdentifier: "WishListTableViewCell")
        wishListTableView.rowHeight = 229
        wishListTableView.separatorStyle = .none
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension WishListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let wishListCell = tableView.dequeueReusableCell(withIdentifier: "WishListTableViewCell") as! WishListTableViewCell
        
      return wishListCell
    }
    
    
}
