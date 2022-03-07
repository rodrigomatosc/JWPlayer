function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

// @ts-nocheck
import React, { createRef, useEffect, useImperativeHandle } from 'react';
import { findNodeHandle, requireNativeComponent, UIManager } from 'react-native';
import InViewPort from './InViewPort';
const JWPLAYER_TAG = 'ImpresaJwplayerView';
export const ImpresaJwplayerComponent = requireNativeComponent(JWPLAYER_TAG);

function ImpresaJwplayerViewManager(props, ref) {
  const uiComponentRef = /*#__PURE__*/createRef();
  const nativeCommands = UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

  const sendCommand = command => {
    const localNativeCommand = nativeCommands[command];

    if (localNativeCommand === undefined) {
      return;
    }
    /* @ts-ignore */


    const playerNodeHandle = findNodeHandle(uiComponentRef.current);
    UIManager.dispatchViewManagerCommand(playerNodeHandle, localNativeCommand, []);
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
    }
  }));
  return /*#__PURE__*/React.createElement(InViewPort, {
    disabled: !props.playPauseWhenVisible,
    onChange: isVisible => {
      if (props.playPauseWhenVisible) {
        isVisible ? sendCommand('play') : sendCommand('pause');
      }
    }
  }, /*#__PURE__*/React.createElement(WrapperJwPlayer, _extends({
    key: props.file
    /* @ts-ignore */
    ,
    ref: uiComponentRef,
    onDestroy: () => {
      sendCommand('destroy');
    }
  }, props)));
}

const WrapperJwPlayer = /*#__PURE__*/React.forwardRef((props, ref) => {
  const nativeCommands = UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;
  useEffect(() => {
    return () => {
      /* @ts-ignore */
      const {
        current
      } = ref;

      if (current) {
        const playerNodeHandle = findNodeHandle(current);
        UIManager.dispatchViewManagerCommand(playerNodeHandle, nativeCommands.destroy, []);
      }
    }; // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [ref]);
  return /*#__PURE__*/React.createElement(ImpresaJwplayerComponent, _extends({}, props, {
    ref: ref
  }));
});
export default /*#__PURE__*/React.memo( /*#__PURE__*/React.forwardRef(ImpresaJwplayerViewManager));
//# sourceMappingURL=index.js.map