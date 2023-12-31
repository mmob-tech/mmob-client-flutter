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
        view=getMarketplace()
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
            title: customerInfo?["title"],
            first_name:customerInfo?["first_name"],
            surname: customerInfo?["surname"],
            dob: customerInfo?["dob"],
            building_number: customerInfo?["building_number"],
            address_1:customerInfo?["address_1"],
            town_city: customerInfo?["town_city"],
            postcode: customerInfo?["postcode"],
            gender: customerInfo?["gender"]
           
           )
       )
        return client.loadIntegration(mmobConfiguration: configuration, instanceDomain: InstanceDomain.EFNETWORK)
    }
}
