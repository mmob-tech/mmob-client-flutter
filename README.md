# mmob-client-flutter

## Flutter Installation

1. Download the Flutter SDK from the official website: https://flutter.dev/docs/get-started/install
2. Extract the downloaded file to a desired location on your computer.
3. Add the Flutter SDK path to your system's PATH environment variable. This step is optional but recommended, as it allows you to run the `flutter` command from any directory in your terminal. To do this, add the following line to your shell profile file (e.g. `~/.bashrc`, `~/.zshrc`, etc.):

`export PATH="$PATH:[PATH_TO_FLUTTER_SDK]/bin"`

Replace `[PATH_TO_FLUTTER_SDK]` with the actual path to your Flutter SDK directory.

4. Run the following command to verify that Flutter is installed correctly:

`flutter doctor`

This command checks your environment and displays a report of the status of your Flutter installation. If there are any issues, the report will provide guidance on how to resolve them.

That's it! You should now have a working installation of Flutter on your computer. Let me know if you have any questions or issues.

5. You will see warnings after running `flutter doctor` please make sure you have this in the `PATH`

`
export PATH="~/flutter/bin:$PATH"
export PATH="~/Library/Android/sdk/cmdline-tools/latest:$PATH"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"`

## Flutter Method Channel

Flutter Method Channels are a communication mechanism that enables Flutter code to call platform-specific code (e.g., Android Java/Kotlin or iOS Objective-C/Swift) and vice versa. This communication is essential when you want to leverage platform-specific functionality that Flutter itself doesn't expose through its plugins or libraries.

### How to implement

how to set up a Method Channel in Flutter:

Dart (Flutter) Side:
`
    
    static const methodChannel = MethodChannel('com.client.mmob/methodChannel');
    String _message = 'BOOT';
      Future<void> _mmobBoot() async {
        final bootInfo = MmobIntegrationConfiguration(
            cpId: 'YOUR_CP_ID_HERE',
            integrationId: 'YOUR_CP_DEPLOYMENT_ID_HERE',
            environment: 'environment');
        final userData = MmobCustomerInfo(
          email: 'user@example.com',
          firstName: 'John',
          surname: 'Doe',
          gender: 'Male',
          title: 'Mr.',
          buildingNumber: '123',
          address1: '123 Main St',
          townCity: 'Cityville',
          postcode: '12345',
          dob: '1990-01-01',
        );
        try {
          await methodChannel.invokeMethod('boot', {
            'integration_configuration': bootInfo.toJson(),
            'customer_info': userData.toJson()
          });
        } on PlatformException catch (e) {
          print(e.message);
        }
      }

`

Native (Android) Side:
// Inside the native code (e.g., MainActivity.kt)
`
    
    import io.flutter.plugin.common.MethodChannel    
    
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

`

Then, you may use our existing SDK for android, you may refer to our public repo: https://github.com/mmob-tech/mmob-client-android
or you may refer to `MmobClientFlutter.kt` under android project to see the example of the view controller we have written
`

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
            client.loadIntegration(integration = integration, customerInfo = customerInfo)
        }

    }`

Native (iOS) Side:
Similar to Android project, please see example codes for the implementation of method channel under `ios` project, `Runner` folder, `AppDelegate.swift`
Then, you may use our existing SDK for iOS, you may refer to our public repo: https://github.com/mmob-tech/mmob-client-ios
or you refer to `MmobViewController.swift`
