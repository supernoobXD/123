
import UIKit

class ViewController: UIViewController,UIWebViewDelegate,UIGestureRecognizerDelegate {
    
    var webView:UIWebView?
    var searchBar:UITextField?
    var isUp:Bool?
    var titleLable:UILabel?
    var upSwipe:UISwipeGestureRecognizer?
    var downSwipe:UISwipeGestureRecognizer?
    
    func loadURL(urlStr:String)  {
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-64))
        webView?.scrollView.bounces = false
        webView?.delegate = self
        isUp = false
        titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-40, height: 20))
        titleLable?.backgroundColor = UIColor.clear
        titleLable?.font = UIFont.systemFont(ofSize: 14)
        titleLable?.textAlignment = .center
        //默认加载百度
        let url = URL(string: "http://www.baidu.com")
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
        self.view.addSubview(webView!)
        //对导航栏进行设置
        creatSearchBar()
        //创建手势
        creatGesture()
        //创建工具栏
        creatToolBar()
    }
    func creatSearchBar()  {
        searchBar = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width-40, height: 30))
        searchBar?.borderStyle = .roundedRect
        let goBtn = UIButton(type: .system)
        goBtn.addTarget(self, action: #selector(goWeb), for: .touchUpInside)
        goBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        goBtn.setTitle("GO", for: .normal)
        searchBar?.rightView = goBtn
        searchBar?.rightViewMode = .always
        searchBar?.placeholder = "请输入网址"
        self.navigationItem.titleView = searchBar
    }
    func creatGesture()  {
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(upSwipeFunc))
        upSwipe?.delegate = self
        upSwipe?.direction = .up
        webView?.addGestureRecognizer(upSwipe!)
        
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(downSwipeFunc))
        downSwipe?.delegate = self
        downSwipe?.direction = .down
        webView?.addGestureRecognizer(downSwipe!)
        
    }
    func creatToolBar() {
        self.navigationController?.setToolbarHidden(false, animated: true)
        let itemHistory = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(goHistory))
        let itemLike = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(goLike))
        let itemBack = UIBarButtonItem(title: "后一页", style: .plain, target: self, action: #selector(goBack))
        let itemForward = UIBarButtonItem(title: "前一页", style: .plain, target: self, action: #selector(goForward))
        let emptyItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let emptyItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let emptyItem3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [itemHistory,emptyItem,itemLike,emptyItem2,itemBack,emptyItem3,itemForward]
    }
    func goForward()  {
        if webView!.canGoForward {
            webView?.goForward()
        }
    }
    func goBack()  {
        if webView!.canGoBack {
            webView?.goBack()
        }
    }
    
    func goLike()  {
        let alert = UIAlertController(title: "温馨提示", message: "请选择您要进行的操作", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "添加收藏", style: .default) { (action) in
            var array:Array<String>? = UserDefaults.standard.value(forKey: "Like") as! Array<String>?
            if array==nil {
                array = Array<String>()
            }
            array?.append(self.webView!.request!.url!.absoluteString)
            UserDefaults.standard.set(array!, forKey: "Like")
            UserDefaults.standard.synchronize()
        }
        let action2 = UIAlertAction(title: "查看收藏夹", style: .default) { (action) in
            let controller = LikeTableViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(action3)
        self.present(alert, animated: true, completion: nil)
        
    }
    func goHistory() {
        let controller = HistoryTableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func goWeb()  {
        if searchBar!.text!.characters.count>0 {
            let url = URL(string: "http://\(searchBar!.text!)")
            let request = URLRequest(url: url!)
            webView?.loadRequest(request)
        }else{
            let alert = UIAlertController(title: "温馨提示", message: "输入的网址不能为空", preferredStyle: .alert)
            let action = UIAlertAction(title: "好的", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func upSwipeFunc(){
        if isUp! {
            return
        }
        self.navigationItem.titleView = nil
        webView!.frame = CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: self.view.frame.size.height-40)
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.frame.size.width, height: 40)
            self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(7, for: .default)
        }) { (finish) in
            self.navigationItem.titleView = self.titleLable!
        }
        self.navigationController?.setToolbarHidden(true, animated: true)
        isUp = true
    }
    func downSwipeFunc()  {
        if webView?.scrollView.contentOffset.y==0 && isUp! {
            self.navigationItem.titleView = nil
            webView?.frame = CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height);
            UIView.animate(withDuration: 0.3, animations: {
                self.navigationController!.navigationBar.frame = CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.frame.size.width, height: 64)
                self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(0, for: .default)
            }, completion: { (finished) in
                self.navigationItem.titleView = self.searchBar!
            })
            self.navigationController?.setToolbarHidden(false, animated: true)
            isUp = false
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        titleLable?.text = webView.request?.url?.absoluteString
        var array:Array<String>? = UserDefaults.standard.value(forKey: "History") as! Array<String>?
        if array==nil {
            array = Array<String>()
        }
        array?.append(titleLable!.text!)
        UserDefaults.standard.set(array!, forKey: "History")
        UserDefaults.standard.synchronize()
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer==upSwipe! || gestureRecognizer==downSwipe! {
            return true
        }else{
            return false
        }
    }
}
