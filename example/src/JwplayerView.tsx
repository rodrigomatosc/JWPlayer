import { useFocusEffect } from '@react-navigation/native';
import React, { useState } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
  YellowBox,
} from 'react-native';
import ImpresaJwplayerViewManager from 'react-native-impresa-jwplayer';

// const TAG_ADS = 'https://playertest.longtailvideo.com/adtags/vmap2.xml';
const MEDIA_ID = 'Ngu7QHmj';
const isIOS = Platform.OS == 'ios';
const keyAndroid = 'vruEVPR8CLdvrqMOjBHcyKud1Z0jUAaz/0LQQKm6VBPE5ulk';
const keyIOS = 'S0rXXMtyuPqRWFL0tL+eYS+KzTazkNQJH5eed+1+gtxuHb2U';

const videos = [
  'https://videos.impresa.pt/sicnot/2021-07-14/747de110-c364-44a7-8e1a-8d754e2d78b4_th-joc3a3o-paulo-gomes/playlist.m3u8',
  'https://live.impresa.pt/live/sic/sic.m3u8',
];

const JwPlayerView: React.FC = () => {
  const jwRef = React.useRef();
  const [file, setFile] = useState(videos[0]);

  useFocusEffect(
    React.useCallback(() => {
      return () => {
        jwRef.current && jwRef.current.pause();
      };
    }, [jwRef])
  );

  React.useEffect(() => {
    // setInterval(() => {
    //   videos.forEach((video) => {
    //     if (video !== file) {
    //       setFile(video);
    //       console.log('trocou', file, video);
    //     }
    //   });
    // }, 5000);
    // setTimeout(() => {
    //   /* @ts-ignore */
    //   jwRef.current?.play();
    // }, 3000);
    // setTimeout(() => {
    //   /* @ts-ignore */
    //   jwRef.current?.pause();
    // }, 6000);
    // setTimeout(() => {
    //   /* @ts-ignore */
    //   jwRef.current?.toggleFullScreen();
    // }, 8000);
  }, []);

  return (
    <View style={styles.container}>
      <ImpresaJwplayerViewManager
        licenseKey={isIOS ? keyIOS : keyAndroid}
        ref={jwRef}
        style={styles.box}
        mediaId={MEDIA_ID}
        title={'JWPLAYER IMPRESA'}
        desc={
          'Vestibulum accumsan, arcu ut finibus posuere, leo lacus finibus neque, sed molestie metus justo eget augue'
        }
        file={file}
        imageFile={'http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg'}
        autostart={false}
        // adSchedule={[
        //   { tag: TAG_ADS, offset: 'pre' },
        //   { tag: TAG_ADS, offset: '10' },
        // ]}
        // volume={0}
        // onFullScreen={() => {
        //   Alert.alert('Teve fullscreen', 'fullscreen');
        // }}
        // onFullScreenExit={() => {
        //   Alert.alert('exit fullscreen', 'fullscreen');
        // }}
        // onPlay={() => {
        //   Alert.alert('onPlay', 'play');
        // }}
        // onPause={() => {
        //   Alert.alert('Pause', 'pause');
        // }}
      />
      <TouchableOpacity
        style={{
          backgroundColor: 'red',
          width: 200,
          height: 40,
          justifyContent: 'center',
          margin: 20,
          alignSelf: 'center',
        }}
        onPress={() => setFile(videos[0])}
      >
        <Text style={{ textAlign: 'center', color: 'white' }}>NORMAL</Text>
      </TouchableOpacity>
      <TouchableOpacity
        style={{
          backgroundColor: 'red',
          width: 200,
          height: 40,
          justifyContent: 'center',
          margin: 20,
          alignSelf: 'center',
        }}
        onPress={() => setFile(videos[1])}
      >
        <Text style={{ textAlign: 'center', color: 'white' }}>LIVE</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2e2e2e',
    // alignItems: 'center',
    // justifyContent: 'center',
  },
  box: {
    width: '100%',
    aspectRatio: 16 / 9,

    marginVertical: 20,
  },
});

export default JwPlayerView;
