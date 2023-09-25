class MmobIntegrationConfiguration {
  String cpId;
  String integrationId;
  String environment;
  String locale;

  MmobIntegrationConfiguration({
    required this.cpId,
    required this.integrationId,
    this.environment = "production",
    this.locale = "en_GB",
  });
  Map<String, dynamic> toJson() {
    return {
      'cp_id': cpId,
      'integration_id': integrationId,
      'environment': environment,
      'locale': locale,
    };
  }
}
