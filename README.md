Note: You need to rename the Config-placeholder file to Config and fill in a valid API-key and protocol string
to run this app.
Also, make sure you add the Config-file to Project>Info>Configurations (I added it to both release and debug).

It might be hard to test the Carplay-functionality - I think you need the proper Entitlements from Apple to
do that. But you can try: 
To test CarPlay functionality, you need to enter the protocol string set in the Entitlements file.
First, enable additional options for CarPlay:
defaults write com.apple.iphonesimulator CarPlayExtraOptions -bool YES
Then, add the string:
defaults write com.apple.iphonesimulator CarPlayProtocols -array-add com.polestar.ps2
Restart simulator
Now it should be possible to open the CarPlay-window when the app is running:
In the Simulator menu, select I/O -> External Displays -> CarPlay.
A pop-up should appear. Choose the default resolution and click 'Run'.

