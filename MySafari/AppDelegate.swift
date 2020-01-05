
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//UIResponder是响应机制，UIApplicationDelegate是回倒机制

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }//有手机打进来时会进入后台

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }//程序在后台继续运行

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }//后台切换回前台

    func applicationDidBecomeActive(_ application: UIApplication) {        
    }//应用程序挂起复原和终止

    func applicationWillTerminate(_ application: UIApplication){
    } //按下home键进入后台


}

