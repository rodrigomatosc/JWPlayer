const path = require('path');

module.exports = {
  dependency: {
    platforms: {
      ios: {
        podspecPath: path.join(
          __dirname,
          'ios',
          'react-native-impresa-jwplayer.podspec'
        ),
      },
      android: {
        packageImportPath:
          'import com.reactnativeimpresajwplayer.ImpresaJwplayerPackage;',
        packageInstance: 'new ImpresaJwplayerPackage()',
      },
    },
  },
};
