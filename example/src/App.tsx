import * as React from 'react';

import { Alert, StyleSheet, View } from 'react-native';
import ImpresaJwplayerViewManager from 'react-native-impresa-jwplayer';

export default function App() {
  const jwRef = React.useRef();
  React.useEffect(() => {
    /* @ts-ignore */
    jwRef.current?.play();
  }, []);

  return (
    <View style={styles.container}>
      <ImpresaJwplayerViewManager
        ref={jwRef}
        color="#2f2f"
        style={styles.box}
        file={
          'https://videos.impresa.pt/sicnot/2021-07-14/747de110-c364-44a7-8e1a-8d754e2d78b4_th-joc3a3o-paulo-gomes/playlist.m3u8'
        }
        imageFile={'http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg'}
        autostart={false}
        heightVideo={100}
        volume={0}
        onFullScreen={() => {
          Alert.alert('Teve fullscreen', 'olha que legal');
        }}
        onFullScreenExit={() => {
          Alert.alert('Saiu PORRA fullscreen', 'olha que legal');
        }}
        onPlay={() => {
          Alert.alert('Play', 'olha que legal');
        }}
        onPause={() => {
          Alert.alert('Pause', 'olha que legal');
        }}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#2e2e2e',
    // alignItems: 'center',
    // justifyContent: 'center',
  },
  box: {
    width: '100%',
    height: '100%',
    marginVertical: 20,
  },
});
