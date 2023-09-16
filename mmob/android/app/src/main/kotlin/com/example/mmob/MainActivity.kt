package com.example.mmob

import androidx.annotation.NonNull
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.example.mmob.MmobClientFlutter

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
                mmobBoot(call.arguments, result)



            }
            else{
                result.notImplemented()
            }
        }

    }

    private fun getMessage(argument: Any?): String? {
        return argument as String?
    }
    private fun mmobBoot(argument: Any?,result: MethodChannel.Result){
        val intent = Intent(this, MmobClientFlutter::class.java)
        startActivity(intent)

        print(intent)


    }

//    private fun getMessage( argument ):String{
//        return "HELLO FROM ANDROID"
//    }

}
