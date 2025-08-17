package org.comunes.ginkgo

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import dev.fluttercommunity.workmanager.WorkmanagerDebug
import dev.fluttercommunity.workmanager.NotificationDebugHandler

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WorkmanagerDebug.setCurrent(NotificationDebugHandler())
    }
}

