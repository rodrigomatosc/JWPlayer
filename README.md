# react-native-impresa-jwplayer

jwplayer lib

## Installation

```sh
npm install react-native-impresa-jwplayer
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
import ImpresaJwplayer from 'react-native-impresa-jwplayer';

// ...

<ImpresaJwplayerViewManager
  licenseKey={'LICENSE_KEY'} // only android
  mediaId={'MEDIA_ID'}
  title={'TITLE'}
  desc={'DESCRIPTION'}
  file={
    'https://videos.impresa.pt/sicnot/2021-07-14/747de110-c364-44a7-8e1a-8d754e2d78b4_th-joc3a3o-paulo-gomes/playlist.m3u8'
  }
  imageFile={'http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg'}
  autostart={false}
  adSchedule={[
    {
      tag: 'https://playertest.longtailvideo.com/adtags/vmap2.xml',
      offset: 'pre',
    },
  ]}
/>;
```

## Available props

| Prop              | Description                      | Type                                     |
| ----------------- | -------------------------------- | ---------------------------------------- | --- |
| **`mediaId`**     | The JW media id.                 | `Int`                                    |
| **`file`**        | The url of the file to play.     | `String`                                 |
| **`title`**       | The title of the track.          | `String`                                 |
| **`imageFile`**   | The url of the player thumbnail. | `String`                                 |
| **`autostart`**   | Should the track auto start.     | `Boolean`                                |     |
| **`desc`**        | Description of the track.        | `String`                                 |
| **`controls`**    | Should the control buttons show. | `Boolean`                                |
| **`repeatVideo`** | Should the track repeat.         | `Boolean`                                |
| **`adSchedule`**  | Array VAST ADS .                 | `Array<{ tag: String; offset: string }>` |

## Available methods

| Func                   | Description                  | Argument  |
| ---------------------- | ---------------------------- | --------- |
| **`play`**             | Starts playing.              | `none`    |
| **`pause`**            | Pauses playing.              | `none`    |
| **`stop`**             | Stops the player completely. | `none`    |
| **`toggleFullScreen`** | Set full screen.             | `Boolean` |

## Available callbacks

| Func                   | Description                  | Argument |
| ---------------------- | ---------------------------- | -------- | --- |
| **`onPlay`**           | Player started playing.      | `none`   |
| **`onPause`**          | Player paused playing.       | `none`   |     |
| **`onFullScreen`**     | Player went into fullscreen. | `none`   |
| **`onFullScreenExit`** | Player exited fullscreen.    | `none`   |

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
