# react-native-impresa-jwplayer

jwplayer lib

## Installation

```sh
npm install react-native-jwplayer
```

#### Add dependencies

##### iOS dependencies

Version < 4.0.0
Follow official instructions [iOS sdk installation](https://developer.jwplayer.com/jwplayer/docs/ios-getting-started) for installation via Cocoapods

add pod 'React-Core', :path => '../node_modules/react-native/React', :modular_headers => true

In your `info.plist` properties file, create a string entry named `JWPlayerKey`, and set its value to be your JW Player Beta license key. Make sure you enter this string exactly as you received it from JW Player, or as it appears in your JW Player Dashboard. The string is case-sensitive.

##### Android dependencies

Version >= 4.0.0

Follow official instructions [Android sdk installation](https://developer.jwplayer.com/jwplayer/docs/android-getting-started)

Insert the following lines inside the allProjects.dependencies block in `android/build.gradle`:

## Usage

```js
import JwplayerViewManager from 'react-native-impresa-jwplayer';

// ...

<JwplayerViewManager
  licenseKey={'LICENSE_KEY'} // only android
  mediaId={'MEDIA_ID'}
  title={'TITLE'}
  desc={'DESCRIPTION'}
  file={''}
  imageFile={''}
  autostart={false}
  adSchedule={[
    {
      tag: '',
      offset: 'pre',
    },
  ]}
/>;
```

## Available props

| Prop                       | Description                                                                          | Type                                     |
| -------------------------- | ------------------------------------------------------------------------------------ | ---------------------------------------- |
| **`mediaId`**              | The JW media id.                                                                     | `Int`                                    |
| **`file`**                 | The url of the file to play.                                                         | `String`                                 |
| **`title`**                | The title of the track.                                                              | `String`                                 |
| **`imageFile`**            | The url of the player thumbnail.                                                     | `String`                                 |
| **`autostart`**            | Should the track auto start.                                                         | `Boolean`                                |
| **`desc`**                 | Description of the track.                                                            | `String`                                 |
| **`controls`**             | Should the control buttons show.                                                     | `Boolean`                                |
| **`repeatVideo`**          | Should the track repeat.                                                             | `Boolean`                                |
| **`adSchedule`**           | Array VAST ADS .                                                                     | `Array<{ tag: String; offset: string }>` |
| **`playPauseWhenVisible`** | Similar to autostart but only call play/pause when the video is visible to the user. | `Boolean`                                |

## Available methods

| Func                   | Description                  | Argument  |
| ---------------------- | ---------------------------- | --------- |
| **`play`**             | Starts playing.              | `none`    |
| **`pause`**            | Pauses playing.              | `none`    |
| **`stop`**             | Stops the player completely. | `none`    |
| **`toggleFullScreen`** | Set full screen.             | `Boolean` |

## Available callbacks

| Func                   | Description                  | Argument |
| ---------------------- | ---------------------------- | -------- |
| **`onPlay`**           | Player started playing.      | `none`   |
| **`onPause`**          | Player paused playing.       | `none`   |
| **`onFullScreen`**     | Player went into fullscreen. | `none`   |
| **`onFullScreenExit`** | Player exited fullscreen.    | `none`   |

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
