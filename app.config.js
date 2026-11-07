const { withProjectBuildGradle } = require('expo/config-plugins');

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
     function (config) {
      return withProjectBuildGradle(config, function (cfg) {
        const contents = cfg.modResults.contents;
    
        if (/ndkVersion\s*=/.test(contents)) {
          cfg.modResults.contents = contents.replace(
            /ndkVersion\s*=.*$/m,
            'ndkVersion = "28.2.13676358"'
          );
        } else {
          cfg.modResults.contents = contents.replace(
            /buildscript\s*\{/,
            'buildscript {\n    ext {\n        ndkVersion = "28.2.13676358"\n    }'
          );
        }
    
        return cfg;
      });
    },
      [
        'expo-build-properties',
        {
          android: {
            compileSdkVersion: 36,
            targetSdkVersion: 36,
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
