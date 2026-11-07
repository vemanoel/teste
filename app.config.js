import { withGradleProperties } from '@expo/config-plugins';

export default {
  expo: {
    name: 'Pornhub TV',
    version: process.env.VERSION_NAME || '0.0.0',
    slug: 'pornhubtv',
    android: {
      package: 'com.pornhubtv.app',
      versionCode: Number(process.env.VERSION_CODE || 1),
    },
    plugins: [
      [
        '@react-native-tvos/config-tv',
        {
          isTV: true,
        },
      ],
      [
        (config) => withGradleProperties(config, (c) => {
            c.modResults.push({
              type: 'property',
              key: 'android.newDsl',
              value: 'false',
            });
    
            c.modResults.push({
              type: 'property',
              key: 'ndkVersion',
              value: '28.2.13676358',
            });
    
            return c;
          }),
      ],
      [
        'expo-build-properties',
        {
          android: {
            compileSdkVersion: 37,
            targetSdkVersion: 37,
            buildToolsVersion: '36.0.0',
            kotlinVersion: '2.2.10',
            minSdkVersion: 26,
            ndkVersion: "28.2.13676358",

            useAndroidX: true,
            gifEnabled: true,
            webpEnabled: true,
            webpAnimated: false,

            buildArchs: ['arm64-v8a', 'armeabi-v7a'],
            enableJetifier: true,
            enableProguardInReleaseBuilds: true,
          },
        },
      ],
    ],
  },
};
