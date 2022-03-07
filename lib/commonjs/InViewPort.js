"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.default = void 0;

var _react = _interopRequireWildcard(require("react"));

var _reactNative = require("react-native");

function _getRequireWildcardCache(nodeInterop) { if (typeof WeakMap !== "function") return null; var cacheBabelInterop = new WeakMap(); var cacheNodeInterop = new WeakMap(); return (_getRequireWildcardCache = function (nodeInterop) { return nodeInterop ? cacheNodeInterop : cacheBabelInterop; })(nodeInterop); }

function _interopRequireWildcard(obj, nodeInterop) { if (!nodeInterop && obj && obj.__esModule) { return obj; } if (obj === null || typeof obj !== "object" && typeof obj !== "function") { return { default: obj }; } var cache = _getRequireWildcardCache(nodeInterop); if (cache && cache.has(obj)) { return cache.get(obj); } var newObj = {}; var hasPropertyDescriptor = Object.defineProperty && Object.getOwnPropertyDescriptor; for (var key in obj) { if (key !== "default" && Object.prototype.hasOwnProperty.call(obj, key)) { var desc = hasPropertyDescriptor ? Object.getOwnPropertyDescriptor(obj, key) : null; if (desc && (desc.get || desc.set)) { Object.defineProperty(newObj, key, desc); } else { newObj[key] = obj[key]; } } } newObj.default = obj; if (cache) { cache.set(obj, newObj); } return newObj; }

function _extends() { _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; }; return _extends.apply(this, arguments); }

class InViewPort extends _react.PureComponent {
  constructor(props) {
    super(props);
    this.state = {
      rectTop: 0,
      rectBottom: 0
    };
  }

  componentDidMount() {
    if (!this.props.disabled) {
      this.startWatching();
    }
  }

  componentWillUnmount() {
    this.stopWatching();
  }

  UNSAFE_componentWillReceiveProps(nextProps) {
    if (nextProps.disabled) {
      this.stopWatching();
    } else {
      this.lastValue = null;
      this.startWatching();
    }
  }

  startWatching() {
    if (this.interval) {
      return;
    }

    this.interval = setInterval(() => {
      if (!this.myview) {
        return;
      }

      this.myview.measure((x, y, width, height, pageX, pageY) => {
        this.setState({
          rectTop: pageY,
          rectBottom: pageY + height,
          rectWidth: pageX + width
        });
      });
      this.isInViewPort();
    }, this.props.delay || 100);
  }

  stopWatching() {
    this.interval = clearInterval(this.interval);
  }

  isInViewPort() {
    const window = _reactNative.Dimensions.get('window');

    const isVisible = this.state.rectBottom !== 0 && this.state.rectTop >= 0 && this.state.rectBottom <= window.height && this.state.rectWidth > 0 && this.state.rectWidth <= window.width;

    if (this.lastValue !== isVisible) {
      this.lastValue = isVisible;
      this.props.onChange(isVisible);
    }
  }

  render() {
    return /*#__PURE__*/_react.default.createElement(_reactNative.View, _extends({
      collapsable: false,
      ref: component => {
        this.myview = component;
      }
    }, this.props), this.props.children);
  }

}

exports.default = InViewPort;
//# sourceMappingURL=InViewPort.js.map