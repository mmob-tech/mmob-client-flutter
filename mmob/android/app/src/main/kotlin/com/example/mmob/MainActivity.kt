package com.example.mmob

import androidx.annotation.NonNull
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import java.io.Serializable

class MainActivity: FlutterActivity() {
    private val channel = "com.client.mmob/methodChannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler{
            call, result->
            if (call.method=="boot"){
                mmobBoot(call.arguments as Map<String,Any>, result)
            }
            else{
                result.notImplemented()
            }
        }
    }
    private fun mmobBoot(argument: Map<String, Any>,result: MethodChannel.Result){
        val intent = Intent(this, MmobClientFlutter::class.java)
        val userInfo = argument?.get("customer_info") as? Map<String, String>
        val configuration = argument?.get("integration_configuration") as? Map<String,String>
        val bundle = Bundle()
        bundle.putSerializable("customer_info", userInfo as Serializable )
        bundle.putSerializable("integration_configuration", configuration as Serializable )
        intent.putExtra("payload",bundle)
        startActivity(intent)
    }
}
