//
//  RightViewControllerSwift.swift
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
protocol RightViewControllerSwiftDelegate:AnyObject {
    func moveToTheLeft()
    func startNewGame()
}
class RightViewControllerSwift: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let reusedIDCell = "itemCellId"
    private var entityArr = [String]()
    private var entityId = [Int]()
    
    weak var delegate:RightViewControllerSwiftDelegate?
    weak var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusedIDCell)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.entityArr, self.entityId) = viewModel?.fetchData(for: .isOnTheRight) ?? ([],[])
        self.tableView.reloadData()
        let res = self.viewModel?.play(on: EntityState.isOnTheRight)
        if(res == false){
            let alert = UIAlertController(title: "You loose", message: "Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
                self?.delegate?.startNewGame()
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        if(viewModel?.isWin() == true){
            let alert = UIAlertController(title: "You win", message: "Press ok to play again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] action in
                self?.delegate?.startNewGame()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func moveToTheLeft(_ sender: Any) {
        delegate?.moveToTheLeft()
    }
    deinit {
        print("RightViewController deinit")
    }
    
}


extension RightViewControllerSwift:UITableViewDataSource{
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
extension RightViewControllerSwift:UITableViewDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let cell = tableView.cellForRow(at: indexPath)
        let inBoard = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "in boat") {[weak self] (action,indexPath) in
            print("In boat for \(indexPath.row)")
            if let id = self?.entityId[indexPath.row]{
                self?.viewModel?.modelChanged(at:id, with: .isInBoat)
                cell?.contentView.backgroundColor = UIColor.black
                cell?.textLabel?.textColor = UIColor.white
            }
            
        }
        let onBank = UITableViewRowAction(style: UITableViewRowAction.Style.destructive, title: "on bank", handler: {[weak self] (action, indexPath) in
            print("itme \(indexPath.row) is on bank")
            if let id = self?.entityId[indexPath.row]{
                self?.viewModel?.modelChanged(at: id, with: .isOnTheRight)
                cell?.contentView.backgroundColor = UIColor.white
                cell?.textLabel?.textColor = UIColor.black
            }
        })
        
        return [inBoard,onBank]
    }
}

