import React, {useState} from 'react';
import {View, StyleSheet, TouchableOpacity, Animated} from 'react-native';
import {Icon} from 'react-native-paper';
import {useNavigation, ParamListBase} from '@react-navigation/native';
import {DrawerNavigationProp} from '@react-navigation/drawer';

const DrawerItem = ({
  item,
  route,
  expand,
  isExpanded,
  textOpacityAnim,
  hasTVPreferredFocus,
}) => {
  const navigation = useNavigation();
  const [isFocused, setIsFocused] = useState(false);
  const isActive = item.screen === route;

  return (
    <TouchableOpacity
      key={item.name}
      hasTVPreferredFocus={hasTVPreferredFocus}
      onFocus={() => {
        setIsFocused(true);
        if (!isExpanded) {
          expand();
        }
      }}
      onBlur={() => {
        setIsFocused(false);
      }}
      onPress={() => {
        navigation.navigate(item.screen);
      }}>
      <View style={styles.menuItem}>
        <Icon
          source={item.icon}
          size={24}
          color={isActive ? '#FF9900' : 'white'}
        />
        <Animated.Text
          style={[
            styles.menuItemText,
            {opacity: textOpacityAnim},
            isFocused && styles.focusedMenuItem,
          ]}>
          {item.name}
        </Animated.Text>
      </View>
    </TouchableOpacity>
  );
};

export default DrawerItem;

const styles = StyleSheet.create({
  menuItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 15,
    height: 54,
  },
  menuItemText: {
    color: 'white',
    marginLeft: 10,
    paddingBottom: 4,
  },
  focusedMenuItem: {
    borderBottomColor: '#FF9900',
    borderBottomWidth: 2,
  },
});
