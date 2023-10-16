# Destiny 2 OAuth Example

This application is a sample app that shows off how you can implement OAuth authentication for iOS + SwiftUI. This applications is by no means a representation of best practices using Swift UI or The Composable Architecture. This is simple something I've cobbled together for an app I'm working on.

I chose to share this since resources and documentation aren't the greatest when it comes to dealing with the Destiny 2 API. So I hope this helps inspire you to build an app for the Destiny 2 community.

## Important Components used

This app makes use of two major things, [Swift UI](https://developer.apple.com/xcode/swiftui/) and The [composable Architecture](https://github.com/pointfreeco/swift-composable-architecture). If the code doesn't make too much sence you can cut right to the implementation and look at the meat and potatoes in the [Destiny2Client](https://github.com/etiennemartin/destiny2-oauth-example/blob/main/Destiny2-OAuth/Destiny2Client/Destiny2Client.swift#L68) implementation.

## Before you try the app 

In order to get this application to work on your machine, you will need to do a few things. Just follow the steps:

1. Register your application with Bungie here: https://www.bungie.net/en/Application
2. Keep the applications apikey, client id, and scheme
3. Clone this repo
4. Update the values in the following file: [Destin2AppValues.swift](https://github.com/etiennemartin/destiny2-oauth-example/blob/main/Destiny2-OAuth/Destiny2Client/Destin2AppValues.swift#L21-L30)
5. Build the app using Xcode (Make sure the TCA Package is downloaded before hand)
6. Run the app!

You should be able to login to the app, and see your name once you've authenticated.

## Screenshots

<img width="464" alt="image" src="https://github.com/etiennemartin/destiny2-oauth-example/assets/647560/dba92cd8-80b1-4b6d-9ede-832201ca6581">

<img width="465" alt="image" src="https://github.com/etiennemartin/destiny2-oauth-example/assets/647560/53721d80-a0a9-4910-9e7e-272a2dc8f2ab">


## Issues or Questions?

If you have any issues, comments or additions you would love to add to the app, feel free to open an issue or post a PR. Contributions are welcome!
