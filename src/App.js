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
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ccff00',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
