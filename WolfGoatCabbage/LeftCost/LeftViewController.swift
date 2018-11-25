//
//  LeftViewController.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

protocol LeftViewControllerDelegate:AnyObject{
    func moveToTheRightSide()
    func startNewGame()
}
class LeftViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let reusedIDCell = "itemCellId"
    private var entityArr = [String]()
    private var entityId = [Int]()
    weak var delegate:LeftViewControllerDelegate?
     var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedIDCell)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.entityArr = viewModel?.fetchData(for: .isOnTheLeft) ?? []
        self.entityId = viewModel?.fetchId(for: .isOnTheLeft) ?? []
        self.tableView.reloadData()
        let res = viewModel?.play(on: .isOnTheLeft)
        if(res == false){
            let alert = UIAlertController(title: "You loose", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
                self?.delegate?.startNewGame()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func moveToTheRightViewController(_ sender: Any) {
        delegate?.moveToTheRightSide()
        
    }
    deinit {
        print("LeftViewController deinit")
    }
    func startNewGame(){
        self.entityArr = viewModel?.fetchData(for: .isOnTheLeft) ?? []
        self.entityId = viewModel?.fetchId(for: .isOnTheLeft) ?? []
        self.tableView.reloadData()
        
    }
    
}

extension LeftViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath)
        let inBoat = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "in boat") {[weak self] (action,indexPath) in
            print("In boat for \(indexPath.row)")
            if let id = self?.entityId[indexPath.row]{
                self?.viewModel?.modelChanged(at:id, with: .isInBoat)
                cell?.contentView.backgroundColor = UIColor.black
                cell?.textLabel?.textColor = UIColor.white
            }
            
            
        }
        inBoat.backgroundColor = UIColor.red
        let onBank = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "on bank", handler: {[weak self] (action, indexPath) in
            print("itme \(indexPath.row) is on bank")
            if let id = self?.entityId[indexPath.row]{
                self?.viewModel?.modelChanged(at: id, with: .isOnTheLeft)
                cell?.contentView.backgroundColor = UIColor.white
                cell?.textLabel?.textColor = UIColor.black
            }
        })
        
        onBank.backgroundColor = UIColor.blue
        
        return [inBoat,onBank]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension LeftViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entityArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedIDCell)
        cell?.textLabel?.text = entityArr[indexPath.row]
        cell?.contentView.backgroundColor = UIColor.white
        cell?.textLabel?.textColor = UIColor.black
        return cell ?? UITableViewCell()
    }
    
    
}
