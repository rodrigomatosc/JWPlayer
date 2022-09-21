import { useFocusEffect } from '@react-navigation/native';
import React, { useState } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from 'react-native';
import ImpresaJwplayerViewManager from 'react-native-impresa-jwplayer';

const TAG_ADS ='';
const MEDIA_ID = '';
const isIOS = Platform.OS == 'ios';
const keyAndroid = '';
const keyIOS = '';

const videos = [];

const JwPlayerView: React.FC = () => {
  const jwRef = React.useRef();
  const [file, setFile] = useState(videos[0]);

  useFocusEffect(
    React.useCallback(() => {
      return () => {
        /* @ts-ignore */
        jwRef.current && jwRef.current.pause();
      };
    }, [jwRef])
  );

  return (
    <View style={styles.container}>
      <ImpresaJwplayerViewManager
        licenseKey={isIOS ? keyIOS : keyAndroid}
        ref={jwRef}
        style={styles.box}
        mediaId={MEDIA_ID}
        title={'JWPLAYER'}
        desc={
          'Vestibulum accumsan, arcu ut finibus posuere, leo lacus finibus neque, sed molestie metus justo eget augue'
        }
        file={file}
        imageFile={''}
        autostart={false}
        adSchedule={[
          { tag: TAG_ADS, offset: 'pre' },
          { tag: TAG_ADS, offset: '10' },
        ]}
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
        playPauseWhenVisible={true}
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
