import 'package:video_monitoring_seventh/src/features/auth/presentation/pages/auth_page.dart';
import 'package:video_monitoring_seventh/src/features/video_player/presentation/pages/video_player_page.dart';

class AppRoutes {
  static final routes = {
    AppRoutes.kInitialRoute: (_) => const AuthPage(),
    AppRoutes.kVideoPlayerRoute: (_) => const VideoPlayerPage(),
  };

  static const kInitialRoute = '/';
  static const kVideoPlayerRoute = '/video_player';
}
