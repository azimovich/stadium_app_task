package com.example.stadium_app_task

import io.flutter.embedding.android.FlutterActivity
import android.app.Application
import com.yandex.mapkit.MapKitFactory
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("e370c49e-ad0a-4893-838f-7c65105dcb23")
        super.configureFlutterEngine(flutterEngine)
    }
}