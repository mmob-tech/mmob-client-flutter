class MmobIntegrationConfiguration {
  String cp_id;
  String integration_id;
  String environment;
  String locale;

  MmobIntegrationConfiguration({
    required this.cp_id,
    required this.integration_id,
    this.environment = "production",
    this.locale = "en_GB",
  });
}
