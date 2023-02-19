import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app_task/core/router/app_routes.dart';
import 'package:uni_links/uni_links.dart';

bool _initialURILinkHandled = false;
class DeepLinkService {

  // handle the UniLinks when the app is terminated
 static Future<void> initURIHandler(BuildContext context) async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      try {
        final initialURI = await getInitialUri();
        if (initialURI != null) {
          if (kDebugMode) {
            log('$initialURI', name: 'initURIHandler');
          }
          // if the link contains a path then navigate to the specific path
          if (initialURI.path.isNotEmpty) {
            final movieId = int.parse(initialURI.pathSegments.first);
            log('movieId: $movieId', name: 'initURIHandler');
            Navigator.of(context).pushNamed(AppRoutes.movieDetailsScreen,
                arguments: int.parse(initialURI.pathSegments.first));
          }
        } else {
          if (kDebugMode) {
            // the is launched without using link or the link is null
            log('Null initial link received when the app is terminated or the app is launched without using link',
                name: 'initURIHandler');
          }
        }
      } on PlatformException {
        if (kDebugMode) {
          log('Failed to receive initial uri',
              name: 'initURIHandlerErrorPlatformException');
        }
      } on FormatException catch (err) {
        if (kDebugMode) {
          log('$err', name: 'initURIHandlerFormatException');
        }
      }
    }
  }

  // handle the UniLinks when the app is in background and not terminated
  static Future<void> incomingLinkHandler(BuildContext context, StreamSubscription? sub) async {
    // Attach a listener to the stream
    sub = linkStream.listen((String? link) {
      if (link != null) {
        final uri = Uri.parse(link);
        if (kDebugMode) {
          log('$uri', name: 'incomingLinkHandler');
        }
        if (uri.path != '') {
          // if the link contains a path then navigate to the specific path
          final movieId = int.parse(uri.pathSegments.first);
          if (kDebugMode) {
            log('movieId: $movieId', name: 'incomingLinkHandler');
          }
          Navigator.of(context)
              .pushNamed(AppRoutes.movieDetailsScreen, arguments: movieId);
        }
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      if (kDebugMode) {
        log('$err', name: 'incomingLinkHandler error');
      }
    });
  }
}
