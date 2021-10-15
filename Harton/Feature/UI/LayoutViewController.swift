//
//  LayoutViewController.swift
//  Harton
//
//  Created by harton on 2021/10/12.
//

import UIKit
import SnapKit
import Moya
import YYWebImage
import SDWebImage
import MJRefresh
import SwiftUI
import SVProgressHUD
import Kingfisher
// MARK:问题 setNeedsLayout与layoutIfNeeded的区

//https://www.jianshu.com/p/77f2c993c283
//https://www.jianshu.com/p/6b808aba3a11

/**
 标记为需要重新布局，不立即刷新，但layoutSubviews一定会被调用
 配合layoutIfNeeded立即更新

 layoutIfNeeded
 如果，有需要刷新的标记，立即调用layoutSubviews进行布局

 
 2.1 总结
 所以，当需要刷新布局时，用setNeedsLayOut方法；当需要重新绘画时，调用setNeedsDisplay方法。



 */
class LayoutViewController: BaseViewController {
    
    enum ImageSetType {
        case yy
        case sd
        case kf
        case none
    }
    var data : [Info] = [Info]()
    let tableView = UITableView(frame: .zero,style: .plain)
    
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        Kingfisher.KingfisherManager.shared.cache.clearDiskCache {
//
//            SVProgressHUD.show(withStatus: "Kingfisher清理完毕")
//            SVProgressHUD.dismiss(withDelay: 1)
//
//            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                SDWebImageManager.shared().imageCache?.clearMemory()
//                SDWebImageManager.shared().imageCache?.clearDisk(onCompletion: {
//                    SVProgressHUD.show(withStatus: "SDWebImageManager清理完毕")
//                    SVProgressHUD.dismiss(withDelay: 1)
//
//                    DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
//                        YYImageCache.shared().diskCache.removeAllObjects {
//                            DispatchQueue.main.async {
//                                SVProgressHUD.show(withStatus: "YYImageCache清理完毕")
//                                SVProgressHUD.dismiss(withDelay: 1)
//                                self.footerRefresh()
//                            }
//                        }
//                        YYImageCache.shared().memoryCache.removeAllObjects()
//                    }
//                })
//            }
//        }
        KingfisherManager.shared.cache.clearDiskCache {
            self.footerRefresh()
        }
        //KingfisherManager.shared.cache.clearMemoryCache()
        
        self.view.setNeedsDisplay()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints({$0.edges.equalToSuperview()})
        tableView.register(cellWithClass: LayoutCell.self)
        
        
        // Do any additional setup after loading the view.
    
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "check", style: .plain, target: self, action: #selector(check))
    }
    @objc func check(){
        print("check")
    }
    @objc func footerRefresh(){
        APIProvider.rx.request(MultiTarget(HartonService.getList(params: ["page":self.page]))).mapObject(type: ResponseData<ListModel>.self).subscribe { response in
            guard let data = response.data?.info else{
                return
            }
            self.tableView.mj_footer?.endRefreshing()
            self.page += 1
            self.data.append(contentsOf: data)
            self.title = response.data?.info?.first?.worksName
            self.tableView.reloadData()
        } onError: { error in
            error.log()
        }.disposed(by: rx.disposeBag)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class LayoutCell: UITableViewCell {
    public let imgView = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self._init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func _init(){
        self.contentView.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    }
}
extension LayoutViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: LayoutCell.self)
        self.setImage(imgView: cell.imgView, info: data[indexPath.row], type: .kf)
        return cell
    }
    
    private func setImage(imgView : UIImageView,info : Info,type : ImageSetType){
        guard let url = info.icon else {
            return
        }
        switch type {
        case .kf:
            imgView.kf.setImage(with: url,options: [.backgroundDecode,.cacheSerializer(DefaultCacheSerializer.default)])
        case .sd:
            imgView.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
        case .yy:
            imgView.yy_setImage(with: url,options: [.ignoreImageDecoding])
        case .none:
            if let data = try? Data(contentsOf: url){
                imgView.image = UIImage(data: data)
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 12 * 2 + 80
    }
}
 
