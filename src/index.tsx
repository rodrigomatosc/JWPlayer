import React, { createRef, useImperativeHandle } from 'react';
import {
  findNodeHandle,
  requireNativeComponent,
  UIManager,
  ViewStyle,
} from 'react-native';

type ImpresaJwplayerProps = {
  color: string;
  file: string;
  style: ViewStyle;
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
};

export const ImpresaJwplayerComponent =
  requireNativeComponent<ImpresaJwplayerProps>('ImpresaJwplayerView');

const ImpresaJwplayerViewManager: React.FC<ImpresaJwplayerProps> =
  React.forwardRef((props, ref) => {
    const testRef = createRef();

    useImperativeHandle(ref, () => ({
      play: () => {
        // const nativeCommands = UIManager.getViewManagerConfig(
        //   'ImpresaJwplayerView'
        // ).Commands;
        /* @ts-ignore */
        // const playerNodeHandle = findNodeHandle(testRef.current);
        // console.log(playerNodeHandle);
        // UIManager.dispatchViewManagerCommand(
        //   playerNodeHandle,
        //   nativeCommands.play,
        //   []
        // );
      },
    }));

    return <ImpresaJwplayerComponent ref={testRef} {...props} />;
  });

export default ImpresaJwplayerViewManager;
