// @ts-nocheck

import React, { createRef, useEffect, useImperativeHandle } from 'react';
import {
  findNodeHandle,
  requireNativeComponent,
  UIManager,
  ViewStyle,
} from 'react-native';
import InViewPort from './InViewPort';

type ImpresaJwplayerProps = {
  licenseKey?: string;
  file?: string;
  style?: ViewStyle;
  imageFile?: string;
  volume?: number;
  autostart?: boolean;
  repeatVideo?: boolean;
  controls?: boolean;
  onFullScreen?: Function;
  onFullScreenExit?: Function;
  onPlay?: Function;
  onPause?: Function;
  ref?: any;
  adSchedule?: Array<{ tag: String; offset: string }>;
  mediaId?: string;
  title?: string;
  desc?: string;
  playPauseWhenVisible?: boolean;
};

const JWPLAYER_TAG = 'JwplayerView';
export const ImpresaJwplayerComponent =
  requireNativeComponent<ImpresaJwplayerProps>(JWPLAYER_TAG);
function ImpresaJwplayerViewManager(props: ImpresaJwplayerProps, ref: any) {
  const uiComponentRef = createRef();
  const nativeCommands = UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

  const sendCommand = (command) => {
    const localNativeCommand = nativeCommands[command];

    if (localNativeCommand === undefined) {
      return;
    }
    /* @ts-ignore */
    const playerNodeHandle = findNodeHandle(uiComponentRef.current);
    UIManager.dispatchViewManagerCommand(
      playerNodeHandle,
      localNativeCommand,
      []
    );
  };

  useImperativeHandle(ref, () => ({
    play: () => {
      sendCommand('play');
    },
    pause: () => {
      sendCommand('pause');
    },
    toggleFullScreen: () => {
      sendCommand('toggleFullScreen');
    },
    destroy: () => {
      sendCommand('destroy');
    },
  }));

  return (
    <InViewPort
      disabled={!props.playPauseWhenVisible}
      onChange={(isVisible) => {
        if (props.playPauseWhenVisible) {
          isVisible ? sendCommand('play') : sendCommand('pause');
        }
      }}
    >
      <WrapperJwPlayer
        key={props.file}
        /* @ts-ignore */
        ref={uiComponentRef}
        onDestroy={() => {
          sendCommand('destroy');
        }}
        {...props}
      />
    </InViewPort>
  );
}

const WrapperJwPlayer: React.FC<ImpresaJwplayerProps> = React.forwardRef(
  (props, ref) => {
    const nativeCommands =
      UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

    useEffect(() => {
      return () => {
        /* @ts-ignore */
        const { current } = ref;
        if (current) {
          const playerNodeHandle = findNodeHandle(current);
          UIManager.dispatchViewManagerCommand(
            playerNodeHandle,
            nativeCommands.destroy,
            []
          );
        }
      };
      // eslint-disable-next-line react-hooks/exhaustive-deps
    }, [ref]);
    return <ImpresaJwplayerComponent {...props} ref={ref} />;
  }
);

export default React.memo(React.forwardRef(ImpresaJwplayerViewManager));
