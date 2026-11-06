import React from 'react';
import {TouchableHighlight, Text, StyleSheet} from 'react-native';

const Header = ({headerText}) => {
  return (
    <TouchableHighlight style={styles.headerContainer}>
      <Text style={styles.headerText}>{headerText}</Text>
    </TouchableHighlight>
  );
};

const styles = StyleSheet.create({
  headerContainer: {
    justifyContent: 'flex-start',
    alignItems: 'center',
    paddingTop: 30,
  },
  headerText: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#FF9900',
  },
});

export default Header;
