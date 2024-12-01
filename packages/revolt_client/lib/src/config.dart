class RevConfig {
  final String baseUrl;
  final int wsPort;
  final int httpPort;

  RevConfig(
      {required this.baseUrl, required this.wsPort, required this.httpPort});

  factory RevConfig.debug() {
    return RevConfig(
      baseUrl: "0.0.0.0",
      httpPort: 14702,
      wsPort: 14703,
    );
  }
}
