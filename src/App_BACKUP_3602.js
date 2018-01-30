<<<<<<< HEAD
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import { StackNavigator } from 'react-navigation';
import HomeScreen from './components/home/Home.js';

const SimpleApp = StackNavigator({
  Home: { screen: HomeScreen }
});

export default class App extends React.Component {
  render() {
    return <SimpleApp />;
=======
import React, { Component } from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';

export default class App extends Component {
  constructor(){
    super();
    this.state = {
      textValue:"Hallo"
    }
  }
  render() {
    return (
      <View style={styles.container }>
        <Button
          onPress={this.onPressLearnMore.bind(this)}
          title="Learn More"
          color="#841584"
          accessibilityLabel="Learn more about this purple button"
        />
        <Text>{this.state.textValue}</Text>
      </View>
    );
  }

  onPressLearnMore = (index, data) => {
    this.setState({
      textValue:"Hi"
    });
>>>>>>> d67b73b06d6ff5424f17d5e0c436409e9f7db9db
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
<<<<<<< HEAD
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center'
  }
});
=======
    backgroundColor: '#ccff00',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
>>>>>>> d67b73b06d6ff5424f17d5e0c436409e9f7db9db
