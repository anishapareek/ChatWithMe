# ChatWithMe

ChatWithMe is a simple iOS application built using SwiftUI that interacts with the Cohere `/chat` API to generate chat responses.

## Features

- Send and receive chat messages.
- Automatically scroll to the latest message.
- Hide keyboard when tapping outside the text field and send button.
- Display error messages for failed API requests.

## Requirements

- Xcode 12 or later
- iOS 14.0 or later
- Swift 5.3 or later

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/anishapareek/ChatWithMe.git
   cd ChatWithMe

2. Open ChatWithMe.xcodeproj in Xcode.
3. Create a Secrets.plist file in the project directory and add your Cohere API key:
   ```bash
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
      <key>COHERE_API_KEY</key>
      <string>YOUR_API_KEY</string>
   </dict>
   </plist>
4. Build and run the project on the simulator or your device.

## Usage
- Enter your message in the text field and press the "Send" button to send a message.
- The chat messages will be displayed in a list and automatically scroll to the latest message.
- Tap anywhere outside the text field to hide the keyboard.
