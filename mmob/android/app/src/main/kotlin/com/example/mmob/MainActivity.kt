package com.example.mmob

import androidx.annotation.NonNull
import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.example.mmob.MmobClientFlutter
import java.io.Serializable

class MainActivity: FlutterActivity() {
    private val channel = "com.client.mmob/methodChannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler{
            call, result->
            if (call.method== "getMessage"){
                val message=getMessage( argument = call.arguments)

                if(message !=null){
                    result.success(message)
                }
                else{
                    result.error("Unavailable", "message from Kotlin not there", null)

                }
            }
            if (call.method=="boot"){
                mmobBoot(call.arguments as? Map<String,Any>, result)



            }
            else{
                result.notImplemented()
            }
        }

    }

    private fun getMessage(argument: Any?): String? {
        return argument as String?
    }
    private fun mmobBoot(argument: Map<String, Any>?,result: MethodChannel.Result){
        val intent = Intent(this, MmobClientFlutter::class.java)
        val customer_info = argument?.get("customer_info") as? Map<String, String>
        print( customer_info)
        val bundle = Bundle()
        bundle.putSerializable("customer_info", customer_info as Serializable )
        intent.putExtra("customer_info",bundle)
        startActivity(intent)

        print(intent)


    }

//    private fun getMessage( argument ):String{
//        return "HELLO FROM ANDROID"
//    }

}
