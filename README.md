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
