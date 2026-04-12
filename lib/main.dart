import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'theme/app_theme.dart';
import 'screens/auth/gateway_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'navigation/main_scaffold.dart';
import 'core/services/audio_player_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// NOTE: After running `flutterfire configure`, uncomment the import below
// and pass `options: DefaultFirebaseOptions.currentPlatform` to initializeApp.
// ─────────────────────────────────────────────────────────────────────────────
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Firebase init ──────────────────────────────────────────────────────────
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // ← uncomment after flutterfire configure
  );

  // ── Background audio init (must come before runApp) ───────────────────────
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.melody.app.melody.channel.audio',
    androidNotificationChannelName: 'Melody Audio',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,
  );

  // ── Singleton audio player init ──────────────────────────────────────────
  await AudioPlayerService.instance.init();

  runApp(const MelodyApp());
}

class MelodyApp extends StatelessWidget {
  const MelodyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Melody - Secure Gateway',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/gateway',
      routes: {
        '/gateway': (context) => const GatewayScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/main': (context) => const MainScaffold(),
      },
    );
  }
}
