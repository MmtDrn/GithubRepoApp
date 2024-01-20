//
//  WebViewVC.swift
//  GithubRepoApp
//
//  Created by mehmet duran on 20.01.2024.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
        
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        
        webView.navigationDelegate = self
        
        return webView
    }()
    
    init(urlString: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        setURL(urlString: urlString)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(webView)
        navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func backAction() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
        
    }
    
    private func setURL(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension WebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        backAction()
    }
}
