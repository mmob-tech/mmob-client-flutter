//
//  MmobViewController.swift
//  Runner
//
//  Created by Alex Woon on 16/09/2023.
//
//
//  MmobViewController.swift
//

import MmobClient
import UIKit
import WebKit

class MmobViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    var webView: MmobClientView!
    let client = MmobClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
        super.loadView()
        
        let customView = getMarketplace()
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
                        customView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                        customView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                        customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                        customView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                    ]
        NSLayoutConstraint.activate(constraints)
    }

    func getMarketplace() -> MmobClientView {
        let configuration = MmobIntegration(
            configuration: MmobIntegrationConfiguration(
                cp_id: "cp_9AidXA6tIpz7RR4thMrrJ",
                integration_id: "cpd_7NNG7KCUjOjagv5Jxt5Ov",
                environment:"stag",
                locale: "en_GB"
            ),
            customer: MmobCustomerInfo(
                email: "john.smith@example.com",
                first_name: "John",
                surname: "Smith",
                title: "Mr",
                building_number: "Flat 81",
                address_1: "Marconi Square",
                town_city: "Chelmsford",
                postcode: "CM1 1XX"
            )
        )

        return client.loadIntegration(mmobConfiguration: configuration, instanceDomain: InstanceDomain.EFNETWORK)
    }
}
