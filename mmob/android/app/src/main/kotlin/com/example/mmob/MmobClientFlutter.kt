package com.example.mmob

import android.os.Bundle
import com.mmob.mmobclient.InstanceDomain
import com.mmob.mmobclient.MmobClient
import com.mmob.mmobclient.MmobView
import io.flutter.embedding.android.FlutterActivity
import android.content.Intent;


class MmobClientFlutter : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        intent = Intent()
        val mmobView: MmobView = findViewById(R.id.mmob_view)

        val client = MmobClient(mmobView, applicationContext, InstanceDomain.EFNETWORK)

        val integration = MmobClient.MmobIntegrationConfiguration(
                cp_id = "cp_9AidXA6tIpz7RR4thMrrJ",
                cp_deployment_id = "cpd_7NNG7KCUjOjagv5Jxt5Ov",
                environment = "stag"
        )

        val customerInfo = MmobClient.MmobCustomerInfo(
                customerInfo = MmobClient.MmobCustomerInfo.Configuration(
                    email = "john.smith@example.com",
                    first_name = "John",
                    surname = "Smith",
                    title = "Mr",
                    building_number = "Flat 81",
                    address_1 = "Marconi Square",
                    town_city = "Chelmsford",
                    postcode = "CM1 1XX"

                )
        )
        print(integration)
        client.loadIntegration(integration = integration, customerInfo = customerInfo)
        //   client.loadDistribution(distribution = distribution, customerInfo = customerInfo)
    }
}