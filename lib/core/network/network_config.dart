import '../../flavours/flavor_config.dart';

const kConnectionTimeout = 60 * 2;
const kReceiveTimeout = 60 * 2;

class IPAddress {
  static const String DEV = 'api.itbook.store/';
  static const String LIVE = 'api.itbook.store/';
}

class ServerProtocol {
  static const String DEV = 'https://';
  static const String LIVE = 'https://';
}

class ContextRoot {
  static const String DEV = '1.0/';
  static const String LIVE = '1.0/';
}

class NetworkConfig {
  static String getNetworkUrl() {
    String url = _getProtocol() + _getIP() + _getContextRoot();
    return url;
  }

  static String _getContextRoot() {
    if (FlavorConfig.isDevelopment()) {
      return ContextRoot.DEV;
    } else {
      return ContextRoot.LIVE;
    }
  }

  static String _getProtocol() {
    if (FlavorConfig.isDevelopment()) {
      return ServerProtocol.DEV;
    } else {
      return ServerProtocol.LIVE;
    }
  }

  static String _getIP() {
    if (FlavorConfig.isDevelopment()) {
      return IPAddress.DEV;
    } else {
      return IPAddress.LIVE;
    }
  }
}

class APIResponse {
  static const String SUCCESS = "00";
}
