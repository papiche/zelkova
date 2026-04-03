package one.astroport.zelkova

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity

// import dev.fluttercommunity.workmanager.WorkmanagerDebug

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Enable debug with: WorkmanagerDebug.setCurrent(NotificationDebugHandler())
    }
}
