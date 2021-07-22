import React, { createRef, useImperativeHandle } from 'react';
import {
  findNodeHandle,
  requireNativeComponent,
  UIManager,
  ViewStyle,
} from 'react-native';

type ImpresaJwplayerProps = {
  color?: string;
  file?: string;
  style?: ViewStyle;
  imageFile?: string;
  volume?: number;
  autostart?: boolean;
  repeatVideo?: boolean;
  controls?: boolean;
  heightVideo?: number;
  widthVideo?: number;
  onFullScreen?: Function;
  onFullScreenExit?: Function;
  onPlay?: Function;
  onPause?: Function;
  ref?: any;
  playlistItem?: object;
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
    }));

    return <ImpresaJwplayerComponent ref={uiComponentRef} {...props} />;
  });

export default ImpresaJwplayerViewManager;
