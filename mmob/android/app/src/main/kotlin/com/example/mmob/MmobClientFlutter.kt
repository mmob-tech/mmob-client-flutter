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
        intent = getIntent()
        val receiveBundle =intent.getBundleExtra("payload")
        val userInfo = receiveBundle?.getSerializable("customer_info") as? Map<String,String>
        val configuration = receiveBundle?.getSerializable("integration_configuration") as? Map<String,String>
        val mmobView: MmobView = findViewById(R.id.mmob_view)

        val client = MmobClient(mmobView, applicationContext, InstanceDomain.EFNETWORK)

        val integration = MmobClient.MmobIntegrationConfiguration(
                cp_id = configuration!!.get("cp_id")!!,
                cp_deployment_id = configuration!!.get("integration_id")!!,
                environment = configuration.get("environment")!!
        )

        val customerInfo = MmobClient.MmobCustomerInfo(
                customerInfo = MmobClient.MmobCustomerInfo.Configuration(
                    email = userInfo?.get("email"),
                    first_name = userInfo?.get("first_name"),
                    surname = userInfo?.get("surname"),
                    title = userInfo?.get("title"),
                    building_number = userInfo?.get("building_number"),
                    address_1 = userInfo?.get("address_1"),
                    town_city = userInfo?.get("town_city"),
                    postcode = userInfo?.get("postcode"),
                    dob = userInfo?.get("dob")

                )
        )
        print(integration)
        client.loadIntegration(integration = integration, customerInfo = customerInfo)
        //   client.loadDistribution(distribution = distribution, customerInfo = customerInfo)
    }
}