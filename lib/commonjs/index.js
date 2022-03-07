"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = exports.ImpresaJwplayerComponent = void 0;

var _react = _interopRequireWildcard(require("react"));

var _reactNative = require("react-native");

var _InViewPort = _interopRequireDefault(require("./InViewPort"));

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _getRequireWildcardCache(nodeInterop) { if (typeof WeakMap !== "function") return null; var cacheBabelInterop = new WeakMap(); var cacheNodeInterop = new WeakMap(); return (_getRequireWildcardCache = function (nodeInterop) { return nodeInterop ? cacheNodeInterop : cacheBabelInterop; })(nodeInterop); }

function _interopRequireWildcard(obj, nodeInterop) { if (!nodeInterop && obj && obj.__esModule) { return obj; } if (obj === null || typeof obj !== "object" && typeof obj !== "function") { return { default: obj }; } var cache = _getRequireWildcardCache(nodeInterop); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (key !== "default" && Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

const JWPLAYER_TAG = 'ImpresaJwplayerView';
const ImpresaJwplayerComponent = (0, _reactNative.requireNativeComponent)(JWPLAYER_TAG);
exports.ImpresaJwplayerComponent = ImpresaJwplayerComponent;

function ImpresaJwplayerViewManager(props, ref) {
  const uiComponentRef = /*#__PURE__*/(0, _react.createRef)();

  const nativeCommands = _reactNative.UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

  const sendCommand = command => {
    const localNativeCommand = nativeCommands[command];

    if (localNativeCommand === undefined) {
      return;
    }
    /* @ts-ignore */


    const playerNodeHandle = (0, _reactNative.findNodeHandle)(uiComponentRef.current);

    _reactNative.UIManager.dispatchViewManagerCommand(playerNodeHandle, localNativeCommand, []);
  };

  (0, _react.useImperativeHandle)(ref, () => ({
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
  return /*#__PURE__*/_react.default.createElement(_InViewPort.default, {
    disabled: !props.playPauseWhenVisible,
    onChange: isVisible => {
      if (props.playPauseWhenVisible) {
        isVisible ? sendCommand('play') : sendCommand('pause');
      }
    }
  }, /*#__PURE__*/_react.default.createElement(WrapperJwPlayer, _extends({
    key: props.file
    /* @ts-ignore */
    ,
    ref: uiComponentRef,
    onDestroy: () => {
      sendCommand('destroy');
    }
  }, props)));
}

const WrapperJwPlayer = /*#__PURE__*/_react.default.forwardRef((props, ref) => {
  const nativeCommands = _reactNative.UIManager.getViewManagerConfig(JWPLAYER_TAG).Commands;

  (0, _react.useEffect)(() => {
    return () => {
      /* @ts-ignore */
      const {
        current
      } = ref;

      if (current) {
        const playerNodeHandle = (0, _reactNative.findNodeHandle)(current);

        _reactNative.UIManager.dispatchViewManagerCommand(playerNodeHandle, nativeCommands.destroy, []);
      }
    }; // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [ref]);
  return /*#__PURE__*/_react.default.createElement(ImpresaJwplayerComponent, _extends({}, props, {
    ref: ref
  }));
});

var _default = /*#__PURE__*/_react.default.memo( /*#__PURE__*/_react.default.forwardRef(ImpresaJwplayerViewManager));

exports.default = _default;
//# sourceMappingURL=index.js.map