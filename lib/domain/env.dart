class Env {
  Env(
    this.apiUrl, {
    this.proxy,
  });

  final String apiUrl;

  /// Optional proxy IP:PORT
  /// will be conveted to 'PROXY 192.168.0.102:9090'
  /// for http client .findProxy
  final String? proxy;
}
