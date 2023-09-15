package com.example.mmob

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val channel = "com.client.mmob/methodChannel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler{
            call, result->
            if (call.method== "getMessage"){
                val message=getMessage()

                if(message.isNotEmpty()){
                    result.success(message)
                }
                else{
                    result.error("Unavailable", "message from Kotlin not there", null)

                }

            }else{
                result.notImplemented()
            }
        }

    }
    private fun getMessage():String{
        return "HELLO FROM ANDROID"
    }
}
