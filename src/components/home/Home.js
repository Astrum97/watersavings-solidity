import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { StackNavigator } from 'react-navigation';
import { Card, ListItem, Button, Header } from 'react-native-elements';
import styles from '../styles/Styles.js';


export default class HomeScreen extends React.Component {
  static navigationOptions = {
    title: 'Overview',
    visible: false
  };
  render() {
    return  (
      <TouchableOpacity>
        
        <Card title='Water used:' titleStyle={[styles.cardHeader]} containerStyle={[styles.cardBackground]}>
            <Text style={[styles.cardBody]} >
              5000l
            </Text>
        </Card>
        <Card title='Outstanding balance:' titleStyle={[styles.cardHeader]} containerStyle={[styles.cardBackground]}>
          <Text style={[styles.cardBody]}>
            R40000
          </Text>
        </Card>
        <Card title='Bounty collected' titleStyle={[styles.cardHeader]} containerStyle={[styles.cardBackground]}>
          <Text style={[styles.cardBody]}>
            2000
          </Text>
        </Card>
      </TouchableOpacity>);
  }
}