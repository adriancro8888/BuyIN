 

import UIKit
import WebKit

class WebViewController: UIViewController ,WKNavigationDelegate {
    
    let url: URL
    let accessToken: String?
   // var caller: CartViewController?
    private let webView = WKWebView(frame: .zero)
    
    // ----------------------------------
    //  MARK: - Init -
    //
    init(url: URL, accessToken: String?) {
        self.url         = url
        self.accessToken = accessToken
        
        super.init(nibName: nil, bundle: nil)
        self.webView.navigationDelegate = self
        self.initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func initialize() {
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
        
        NSLayoutConstraint.activate([
            self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        
        self.load(url: self.url)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let urlStr = navigationAction.request.url?.absoluteString {
            
            
            if   urlStr.contains("/thank_you") {
                print("Recevied OK !")
                decisionHandler(.allow)
                self.dismiss(animated: true) {
                    CartController.shared.emptyCart()
                    
                }
            }
            else{
                decisionHandler(.allow)
            }
            
        }
        else{
            decisionHandler(.allow)
        }
        
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //let responce  = navigationResponse.response
      //  print("=========================navigationResponse")
      //  print(responce)
      
        decisionHandler(.allow)
    }
    // ----------------------------------
    //  MARK: - Request -
    //
    private func load(url: URL) {
        var request = URLRequest(url: self.url)
        
        if let accessToken = self.accessToken {
            request.setValue(accessToken, forHTTPHeaderField: "X-Shopify-Customer-Access-Token")
        }
        
        self.webView.load(request)
    }
}
