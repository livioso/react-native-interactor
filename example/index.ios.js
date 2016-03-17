/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */


'use strict';
import React, {
  AppRegistry,
  NativeAppEventEmitter,
  Component,
  StyleSheet,
  Text,
  View
} from 'react-native';

class example extends Component {

  componentWillMount() {
    const interactor = require('NativeModules').RNInteractor;

    interactor.setup();
    interactor.isRunning(result => {
      alert(result);
    });

    let listenerEvents = NativeAppEventEmitter.addListener(
      'eventTriggered', (event) => alert(event.name));

    let beaconEvents = NativeAppEventEmitter.addListener(
      'didRangeRegion', (beacon) => alert(beacon.rssi));
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('example', () => example);
