import React from 'react';
import {StyleSheet, SafeAreaView} from 'react-native';
import {Header} from '../components';

const SettingsScreen = () => {
  return (
    <SafeAreaView style={styles.container}>
      <Header headerText="Settings" />
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#12181F',
  },
});

export default SettingsScreen;
