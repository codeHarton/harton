//
//  NetViewController.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//

import UIKit
import Moya
import RxSwift
import AsyncDisplayKit
class NetViewController: BaseViewController {

    lazy var viewModel = RxNetViewModel()
    
    lazy var tableView = ASTableNode()
    
    var dataSource : [Info] = [Info]()
    
    var page = 2
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTable()
        viewModel.loadData.subscribe { response in
            guard let data = response.data?.info else{
                return
            }
            self.dataSource = data
            self.title = response.data?.info?.first?.worksName
            self.tableView.reloadData()
        } onError: { error in
            error.log()
        }.disposed(by: rx.disposeBag)
        
  
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = self.view.bounds
    }
    
    private func setupTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.view.separatorStyle = .none
        view.addSubnode(tableView)

    }
    


}

extension NetViewController : ASTableDelegate,ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        return NetCellNode(info: dataSource[indexPath.row])
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.beginBatchFetching()
        fetchData(context: context)
    }
    
    private func fetchData(context: ASBatchContext){
        APIProvider.rx.request(MultiTarget(HartonService.getList(params: ["page":self.page]))).mapObject(type: ResponseData<ListModel>.self).subscribe { response in
            guard let data = response.data?.info else{
                return
            }
            self.page += 1
            self.dataSource.append(contentsOf: data)
            self.title = response.data?.info?.first?.worksName
            context.completeBatchFetching(true)
            self.tableView.reloadData()
        } onError: { error in
            error.log()
        }.disposed(by: rx.disposeBag)
    }
}


class NetCellNode: ASCellNode {
    lazy var nickName = ASTextNode()
    lazy var video_quality = ASTextNode()
    
    lazy var type = ASTextNode()


    lazy var imageView = ASNetworkImageNode()
    
    lazy var videoCoverImageView = ASNetworkImageNode()//ASNetworkImageNode(cache: ASImageProtocolServcie.getService(), downloader: ASImageProtocolServcie.getService())

    
    lazy var videoNode = ASVideoPlayerNode()
    let info : Info
    init(info : Info) {
        self.info = info
        super.init()
        _init()
    }
    
    private func _init(){
        addSubnode(nickName)
        nickName.attributedText = NSAttributedString(string: info.nickname ?? "高清", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        addSubnode(type)
        type.attributedText = NSAttributedString(string: info.type ?? "mp4", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        addSubnode(video_quality)
        video_quality.attributedText = NSAttributedString(string: info.video_quality ?? "leo", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        
        
        imageView.style.preferredSize = CGSize(width: 60, height: 60)
        addSubnode(imageView)
        imageView.url = info.icon
        imageView.cornerRadius = 30
        
        
        
        addSubnode(videoCoverImageView)
        videoCoverImageView.url = info.icon_origin
        videoCoverImageView.cornerRadius = 4
        
//        addSubnode(videoNode)
//        videoNode.assetURL = URL(string: "http://testfilebizhi.feihuo.com/video/sourceFile/20190222/448654de455aee18ce0a0d154075133b.mp4")
//        videoNode.gravity = AVLayerVideoGravity.resizeAspectFill.rawValue
        
    
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let top = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .spaceBetween, alignItems: .start, flexWrap: .noWrap, alignContent: .stretch, lineSpacing: 10, children: [nickName,type,video_quality])
        let infoLayout = ASStackLayoutSpec(direction: .horizontal, spacing: 12, justifyContent: .start, alignItems: .start, children: [imageView,top])
        
        let origin_cover = ASRatioLayoutSpec(ratio: 0.5, child: videoCoverImageView)
        
       // let videoLayout = ASRatioLayoutSpec(ratio: 0.5, child: videoNode)

        let layout = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [infoLayout,origin_cover])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), child: layout)
    }
}
