export default {
  expo: {
    name: 'Pornhub TV',
    version: process.env.APP_VERSION || '0.0.0',
    slug: 'pornhubtv',
    android: {
      package: 'com.pornhubtv.app',
      versionCode: Number(process.env.ANDROID_VERSION_CODE || 1),
    },
    plugins: [
      [
        '@react-native-tvos/config-tv',
        {
          isTV: true,
        },
      ],
      [
        'expo-build-properties',
        {
          android: {
            compileSdkVersion: 36,
            targetSdkVersion: 36,
            buildToolsVersion: '35.0.0',
            kotlinVersion: '2.1.20',
            minSdkVersion: 26,

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
