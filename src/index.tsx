import { requireNativeComponent, ViewStyle } from 'react-native';

type ImpresaJwplayerProps = {
  color: string;
  style: ViewStyle;
};

export const ImpresaJwplayerViewManager = requireNativeComponent<ImpresaJwplayerProps>(
'ImpresaJwplayerView'
);

export default ImpresaJwplayerViewManager;
