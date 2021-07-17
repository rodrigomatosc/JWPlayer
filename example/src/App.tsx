import * as React from 'react';

import { StyleSheet, View } from 'react-native';
import ImpresaJwplayerViewManager from 'react-native-impresa-jwplayer';

export default function App() {
  return (
    <View style={styles.container}>
      <ImpresaJwplayerViewManager
        color="#2f2f2"
        style={styles.box}
        file={
          'https://videos.impresa.pt/sicnot/2021-07-14/747de110-c364-44a7-8e1a-8d754e2d78b4_th-joc3a3o-paulo-gomes/playlist.m3u8'
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    // alignItems: 'center',
    // justifyContent: 'center',
  },
  box: {
    width: '100%',
    aspectRatio: 16 / 9,
    marginVertical: 20,
  },
});
