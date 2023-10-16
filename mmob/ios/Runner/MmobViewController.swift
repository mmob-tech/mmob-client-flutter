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
    var arguments: [String: Any]!
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
        let integrationConfiguration = arguments["integration_configuration"] as! [String: String]
        let customerInfo = arguments["customer_info"] as? [String: String]
        let configuration = MmobIntegration(
           configuration: MmobIntegrationConfiguration(
            cp_id: integrationConfiguration["cp_id"]!,
            integration_id:integrationConfiguration["integration_id"]!,
            environment:integrationConfiguration["environment"]!,
            locale: integrationConfiguration["locale"] ?? "en_GB"
           ),
           customer: MmobCustomerInfo(
            email: customerInfo?["email"],
            first_name:customerInfo?["first_name"],
            surname: customerInfo?["surname"],
            gender: customerInfo?["gender"],
            title: customerInfo?["title"],
            building_number: customerInfo?["building_number"],
            address_1:customerInfo?["address_1"],
            town_city: customerInfo?["town_city"],
            postcode: customerInfo?["postcode"],
            dob: customerInfo?["dob"]
           )
       )
        return client.loadIntegration(mmobConfiguration: configuration, instanceDomain: InstanceDomain.EFNETWORK)
    }
}
