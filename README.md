# Blank React Native 0.63.4 Project

## Setup Project
1. Clone repo 
2. Run `yarn` to install dependencies
3. cd into `ios` and run `pod install` 

## Run Project
Before continuing you must ensure the terminal you are running in is running in rosetta.
You can verify this by running `arch` in your terminal and confirming that what you see is `i386`.

1. Open one terminal and run `npx react-native start`
2. Open another terminal and run `npx react-native run-ios`

## Helpful Resources

- **React Native 0.63.4 Docs:** https://reactnative.dev/docs/0.63/getting-started


## Having Issues ?
![](https://media.giphy.com/media/tZCkL6BsL2AAo/giphy.gif)

It took a bit of fiddling to get this setup so here is what I had to do to make it work for my M1 Macbook.

1. I had to uninstall Ruby from homebrew as well as reinstall `cocoapods` and `ffi` but have it target `x86_64` follow [this Stack Overflow](https://stackoverflow.com/questions/66644365/cocoapods-on-m1-apple-silicon-fails-with-ffi-wrong-architecture) answer for more detailed steps.
2. I had to remove the flipper installation step from the `Podfile` in the `ios` folder check out this [Github Issue](https://github.com/react-native-community/upgrade-support/issues/155#issuecomment-828128468) for more information.