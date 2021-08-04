import React, { createRef, useEffect, useImperativeHandle } from 'react';
import {
  findNodeHandle,
  requireNativeComponent,
  UIManager,
  ViewStyle,
} from 'react-native';

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
  playlistItem?: object;
  adSchedule?: Array<{ tag: String; offset: string }>;
  mediaId?: string;
  title?: string;
  description?: string;
};

const JWPLAYER_TAG = 'ImpresaJwplayerView';
export const ImpresaJwplayerComponent =
  requireNativeComponent<ImpresaJwplayerProps>(JWPLAYER_TAG);

const ImpresaJwplayerViewManager: React.FC<ImpresaJwplayerProps> =
  React.forwardRef((props, ref) => {
    const uiComponentRef = createRef();
    const nativeCommands =
      UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

    useImperativeHandle(ref, () => ({
      play: () => {
        /* @ts-ignore */
        const playerNodeHandle = findNodeHandle(uiComponentRef.current);
        UIManager.dispatchViewManagerCommand(
          playerNodeHandle,
          nativeCommands.play,
          []
        );
      },
      pause: () => {
        /* @ts-ignore */
        const playerNodeHandle = findNodeHandle(uiComponentRef.current);
        UIManager.dispatchViewManagerCommand(
          playerNodeHandle,
          nativeCommands.pause,
          []
        );
      },
      toggleFullScreen: () => {
        /* @ts-ignore */
        const playerNodeHandle = findNodeHandle(uiComponentRef.current);
        UIManager.dispatchViewManagerCommand(
          playerNodeHandle,
          nativeCommands.toggleFullScreen,
          []
        );
      },
      destroy: () => {
        destroyPlayer();
      },
    }));

    const destroyPlayer = () => {
      /* @ts-ignore */
      const playerNodeHandle = findNodeHandle(uiComponentRef.current);
      UIManager.dispatchViewManagerCommand(
        playerNodeHandle,
        nativeCommands.destroy,
        []
      );
    };

    useEffect(() => {
      return () => {
        destroyPlayer();
      };
    }, []);

    return <ImpresaJwplayerComponent ref={uiComponentRef} {...props} />;
  });

export default ImpresaJwplayerViewManager;
