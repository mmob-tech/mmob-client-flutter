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
                cp_id = "cp_TMaiVSyyzBx2rZqF-PqdY",
                cp_deployment_id = "cpd_62FuIeyfZh51gaYkBIr6Z",
                environment = "stag"
        )

        val customerInfo = MmobClient.MmobCustomerInfo(
                customerInfo = MmobClient.MmobCustomerInfo.Configuration(

                )
        )
        print(integration)
        client.loadIntegration(integration = integration, customerInfo = customerInfo)
        //   client.loadDistribution(distribution = distribution, customerInfo = customerInfo)
    }
}