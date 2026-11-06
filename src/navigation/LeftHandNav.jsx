import React from 'react';
import {
  createDrawerNavigator,
  DrawerContentComponentProps,
} from '@react-navigation/drawer';
import {
  HomeScreen,
  MoviesScreen,
  SettingsScreen,
  TVShowsScreen,
} from '../screens';
import DrawerContent from './DrawerContent';

const Drawer = createDrawerNavigator();

const LeftHandNav = () => {
  return (
    <Drawer.Navigator
      drawerContent={(props) => {
        const {state} = props;
        const currentRoute = props.state.routeNames[state.index];
        return <DrawerContent route={currentRoute} />;
      }}
      screenOptions={{
        drawerType: 'permanent',
        drawerStyle: {
          width: 'auto',
        },
        headerShown: false,
      }}>
      <Drawer.Screen name="Home" component={HomeScreen} />
      <Drawer.Screen name="Movies" component={MoviesScreen} />
      <Drawer.Screen name="TVShows" component={TVShowsScreen} />
      <Drawer.Screen name="Settings" component={SettingsScreen} />
    </Drawer.Navigator>
  );
};

export default LeftHandNav;
