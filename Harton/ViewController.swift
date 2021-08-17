//
//  ViewController.swift
//  Harton
//
//  Created by harton on 2021/8/17.
//

import UIKit

import RxCocoa
import RxSwift
class ViewController: BaseViewController {
    
    struct Item {
        var name : String
        var type : UIViewController.Type
    }

    @IBOutlet weak var tableView : UITableView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        Observable.just([Item(name: "沙盒", type: SandBoxViewController.self)]).bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)){ row, ele, cell in
            print("row = \(row),ele = \(ele),cell = \(cell)")
            cell.textLabel?.text = ele.name
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(Item.self).subscribe { [weak self] item in
            guard let type = item.element?.type else{
                return
            }
            let vc = type.init()
            vc.title = item.element?.name
            self?.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    


}

