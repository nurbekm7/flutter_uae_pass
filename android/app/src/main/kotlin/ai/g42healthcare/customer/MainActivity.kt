package ai.g42healthcare.customer

import android.content.Intent
import android.os.Bundle

import androidx.annotation.NonNull

import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent: Intent = getIntent()
        val action: String? = intent.getAction()
        val type: String? = intent.getType()
        val dataString = intent.data?.toString()
        println("MainActivity: " + intent)
        println("MainActivity: intent " + intent.getDataString())
        println("MainActivity: type " + type)
        println("MainActivity: intent " + intent.getDataString())
        println("MainActivity: dataString " + dataString)

        val extrasMap = intent.extras?.keySet()?.map { it to intent.extras?.get(it) }
        println("extrasMap: " + extrasMap)
        // for( i in extrasMap.keys) {
        //     println("extrasMap: " + extrasMap[i])
        // }
       


        // if (Intent.ACTION_VIEW == action && type != null) {
        //     if ("text/plain" == type) {
        //         handleSendText(intent) // Handle text being sent
        //     }
        // }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler { call, result ->
                print("MainActivity call.method: " + call.method)
                if (call.method.contentEquals("getSharedText")) {
                    result.success(sharedText)
                    sharedText = null
                }
            }
    }

//    override fun onNewIntent(intent: Intent) {
//         super.onNewIntent(intent)
//         println()
//     } 

    fun handleSendText(intent: Intent) {
        sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
    }

    companion object {
        private const val CHANNEL = "flutter_uae_pass"
    }
}