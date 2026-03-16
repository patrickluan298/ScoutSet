class ApiService {
  const ApiService({
    this.baseUrl = 'https://api.scoutset.local',
  });

  final String baseUrl;

  Future<Map<String, dynamic>> get(String endpoint) async {
    return <String, dynamic>{
      'endpoint': endpoint,
      'method': 'GET',
      'baseUrl': baseUrl,
      'message': 'Stub pronto para futura integracao com backend em Python.',
    };
  }
}

