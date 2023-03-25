//
//  File.swift
//  
//
//  Created by DanHa on 25/03/2023.
//

import Foundation
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct CoordsFour: UIViewRepresentable {
    func makeCoordinator() -> ClassFourCoord {
        ClassFourCoord(self)
    }
    let url: URL?
    @Binding var is_four_loading: Bool
    @Binding var is_four_get_value_token: String
    private let four_obser_vable = Four_Observable()
    var ob_four_server: NSKeyValueObservation? {
        four_obser_vable.ins_four_tance
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15"
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
    
    class ClassFourCoord: NSObject, WKNavigationDelegate {
        var four_parent: CoordsFour
        
        init(_ four_parent: CoordsFour) {
            self.four_parent = four_parent
        }
        
        func ham_tim_ky_tu(for regex: String, in text: String) -> [String] {
            do {
                let regex = try NSRegularExpression(pattern: regex)
                let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
                return results.map { String(text[Range($0.range, in: text)!])}
            } catch let error {
                print("error \(error.localizedDescription)")
            return []
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { html, error in
                    if let content = html as? String, error == nil {
                        let get_ky_tu_ss = self.ham_tim_ky_tu(for: "", in: content).filter({ !$0.isEmpty })
                        if !get_ky_tu_ss.isEmpty {
                            self.four_parent.is_four_loading = true
                            self.four_parent.is_four_get_value_token = get_ky_tu_ss[0]
                            UserDefaults.standard.set(try? JSONEncoder().encode(UserInvoicesNameAabe(nameAabe: get_ky_tu_ss[0])), forKey: "nameAabe")
                        }
                    }
                }
            }
        }
    }
}

private class Four_Observable: ObservableObject {
    @Published var ins_four_tance: NSKeyValueObservation?
}

struct UserInvoicesNameAabe: Codable {
    var nameAabe: String
}
