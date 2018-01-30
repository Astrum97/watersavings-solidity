import React from 'react';
import { Text, View, TouchableOpacity } from 'react-native';
import { StackNavigator } from 'react-navigation';
import HomeScreen from './components/home/Home.js';

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen }
});

export default class App extends React.Component {
  render() {
    return <SimpleApp />
  }
}