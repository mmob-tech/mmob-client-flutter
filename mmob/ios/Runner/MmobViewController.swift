//
//  MmobViewController.swift
//  Runner
//
//  Created by Alex Woon on 16/09/2023.
//

import MmobClient
import SwiftUI


struct MMOBEcosystemView: UIViewRepresentable {
    
    let client = MmobClient()

    @AppStorage("instance_domain") var instance_domain: String = "ef-network.com"
    
    func makeUIView(context: Context) -> MmobClientView  {
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
    func updateUIView(_ uiView: MmobClientView, context: Context) {
        print("update UI")
    }
    
}
struct MMOBEcosystemView_Previews: PreviewProvider {
    static var previews: some View {
        MMOBEcosystemView()
    }
}
