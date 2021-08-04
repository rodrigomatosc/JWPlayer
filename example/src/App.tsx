import * as React from 'react';
import 'react-native-gesture-handler';
import JwPlayerView from './JwplayerView';
import { NavigationContainer, StackActions } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { TouchableOpacity } from 'react-native-gesture-handler';
import { Text, View } from 'react-native';

const Tab = createBottomTabNavigator();
const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Tab.Navigator>
        <Tab.Screen name="First Tab" component={JwplayerViewStack} />
        <Tab.Screen name="Secont Tab" component={JwPlayerView} />
      </Tab.Navigator>
    </NavigationContainer>
  );
}

const JwplayerViewStack: React.FC = () => {
  return (
    <Stack.Navigator>
      <Stack.Screen name="First" component={JwplayerViewScreen} />
      <Stack.Screen name="Second" component={JwPlayerView} />
    </Stack.Navigator>
  );
};

interface JwplayerViewScreenProps {
  navigation: object;
}

const JwplayerViewScreen: React.FC<JwplayerViewScreenProps> = ({
  navigation,
}) => {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <JwPlayerView />
      <TouchableOpacity
        onPress={() => {
          const pushAction = StackActions.push('Second');
          /* @ts-ignore */
          navigation.dispatch(pushAction);
        }}
        style={{
          width: 200,
          height: 50,
          backgroundColor: '#2e2e2e',
          marginVertical: 10,
        }}
      >
        <Text
          style={{
            color: '#fff',
            flex: 1,
            textAlign: 'center',
            textAlignVertical: 'center',
          }}
        >
          go second
        </Text>
      </TouchableOpacity>
    </View>
  );
};
