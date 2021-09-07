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
  adSchedule?: Array<{ tag: String; offset: string }>;
  mediaId?: string;
  title?: string;
  desc?: string;
};

const JWPLAYER_TAG = 'ImpresaJwplayerView';
export const ImpresaJwplayerComponent =
  requireNativeComponent<ImpresaJwplayerProps>(JWPLAYER_TAG);

// export default class ImpresaJwplayerViewManager extends React.Component<ImpresaJwplayerProps> {
//   constructor() {
//     super();
//     /* @ts-ignore */
//     this.uiComponentRef = null;
//     /* @ts-ignore */
//     this.nativeCommands = UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;
//   }

//   static getDerivedStateFromProps(props, state) {
//     console.log(props, state);
//     return props;
//   }

//   componentDidMount() {
//     console.log('comoponent novo');
//   }

//   play = () => {
//     /* @ts-ignore */
//     const playerNodeHandle = findNodeHandle(this.uiComponentRef.current);
//     UIManager.dispatchViewManagerCommand(
//       playerNodeHandle,
//       /* @ts-ignore */
//       this.nativeCommands.play,
//       []
//     );
//   };

//   pause = () => {
//     /* @ts-ignore */
//     const playerNodeHandle = findNodeHandle(this.uiComponentRef.current);
//     UIManager.dispatchViewManagerCommand(
//       playerNodeHandle,
//       /* @ts-ignore */
//       this.nativeCommands.pause,
//       []
//     );
//   };

//   toggleFullScreen = () => {
//     /* @ts-ignore */
//     const playerNodeHandle = findNodeHandle(this.uiComponentRef.current);
//     UIManager.dispatchViewManagerCommand(
//       playerNodeHandle,
//       /* @ts-ignore */
//       this.nativeCommands.toggleFullScreen,
//       []
//     );
//   };

//   destroy = () => {
//     this.destroyPlayer();
//   };

//   destroyPlayer = () => {
//     /* @ts-ignore */
//     const playerNodeHandle = findNodeHandle(this.uiComponentRef.current);
//     UIManager.dispatchViewManagerCommand(
//       playerNodeHandle,
//       /* @ts-ignore */
//       this.nativeCommands.destroy,
//       []
//     );
//   };

//   render() {
//     return (
//       <ImpresaJwplayerComponent
//         key={this.props.file}
//         /* @ts-ignore */
//         ref={(ref) => (this.uiComponentRef = ref)}
//         {...this.props}
//       />
//     );
//   }
// }

function ImpresaJwplayerViewManager(props: ImpresaJwplayerProps, ref: any) {
  const uiComponentRef = createRef();
  const nativeCommands = UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

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

  return (
    <WrapperJwPlayer
      key={props.file}
      /* @ts-ignore */
      ref={uiComponentRef}
      {...props}
    />
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

    /* @ts-ignore */
    return <ImpresaJwplayerComponent {...props} ref={ref} />;
  }
);

export default React.memo(React.forwardRef(ImpresaJwplayerViewManager));
