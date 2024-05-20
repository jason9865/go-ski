package com.example.goski_student

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.net.URISyntaxException

class MainActivity : FlutterActivity() {
    private val CHANNEL = "lesson_payment_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        Log.d("로그", "MainActivity - onCreate() 호출됨")

        MethodChannel(
            flutterEngine!!.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getAppUrl" -> {
                    try {
                        val url: String = call.argument<String>("url")!!
                        val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
                        result.success(intent.dataString)
                    } catch (e: URISyntaxException) {
                        result.notImplemented()
                    } catch (e: Exception) {
                        result.notImplemented()
                    }
                }

                "getMarketUrl" -> {
                    try {
                        val url: String = call.argument<String>("url")!!
                        val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
                        val packageName = intent.`package`
                        if (packageName != null) {
                            result.success("market://details?id=$packageName")
                        } else {
                            result.notImplemented()
                        }
                    } catch (e: URISyntaxException) {
                        result.notImplemented()
                    } catch (e: Exception) {
                        result.notImplemented()
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}