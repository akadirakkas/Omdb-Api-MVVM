//
//  BaseViewController.swift
//  Omdb-Api
//
//  Created by kadir on 29.10.2022.
//


import UIKit

class BaseViewController: UIViewController {

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .fullScreen }
        set { }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard #available(iOS 13.0, *) else { return .default }
        return .lightContent
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func showAlertMessage(
        _ message: String,
        detail: String? = nil,
        showCancel: Bool = false,
        completion: (() -> Void)? = nil,
        cancelCompletion: (() -> Void)? = nil
    ) {
        let title: String? = (detail == nil) ? nil : message
        let message: String? = (detail == nil) ? message : detail
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        if showCancel == true {
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            guard !(self.presentedViewController is UIAlertController) else { return }
            self.present(alertVC, animated: true, completion: nil)
        }
    }

}
