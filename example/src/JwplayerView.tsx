import React from 'react';
import { StyleSheet, View } from 'react-native';
import ImpresaJwplayerViewManager from 'react-native-impresa-jwplayer';

const TAG_ADS = 'https://playertest.longtailvideo.com/adtags/vmap2.xml';
const MEDIA_ID = 'Ngu7QHmj';

const JwPlayerView: React.FC = () => {
  const jwRef = React.useRef();
  React.useEffect(() => {
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
        licenseKey={'vruEVPR8CLdvrqMOjBHcyKud1Z0jUAaz/0LQQKm6VBPE5ulk'}
        ref={jwRef}
        style={styles.box}
        mediaId={MEDIA_ID}
        title={'JWPLAYER IMPRESA'}
        desc={
          'Vestibulum accumsan, arcu ut finibus posuere, leo lacus finibus neque, sed molestie metus justo eget augue'
        }
        file={
          // 'https://videos.impresa.pt/sicnot/2021-07-14/747de110-c364-44a7-8e1a-8d754e2d78b4_th-joc3a3o-paulo-gomes/playlist.m3u8'
          'https://live.impresa.pt/live/sic/sic.m3u8'
        }
        imageFile={'http://d3el35u4qe4frz.cloudfront.net/bkaovAYt-480.jpg'}
        autostart={false}
        // adSchedule={[{ tag: TAG_ADS, offset: 'pre' }]}
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
