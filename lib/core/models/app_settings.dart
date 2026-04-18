class AppSettings {
  final String marketplaceName;
  final String tagline;
  final String supportEmail;
  final String supportPhone;
  final String footerMessage;
  final String logo;
  final String favicon;
  final bool enableAnnouncement;
  final String announcementMessage;
  final String announcementLink;
  final String contactPhone;
  final String contactEmail;
  final String contactAddress;
  final String returnRefundPolicy;
  final String termsConditions;
  final String privacyPolicy;

  AppSettings({
    required this.marketplaceName,
    required this.tagline,
    required this.supportEmail,
    required this.supportPhone,
    required this.footerMessage,
    required this.logo,
    required this.favicon,
    required this.enableAnnouncement,
    required this.announcementMessage,
    required this.announcementLink,
    required this.contactPhone,
    required this.contactEmail,
    required this.contactAddress,
    required this.returnRefundPolicy,
    required this.termsConditions,
    required this.privacyPolicy,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      marketplaceName: json['marketplaceName'] ?? 'OJAS',
      tagline: json['tagline'] ?? 'Where Great Products Meet Happy Customers',
      supportEmail: json['supportEmail'] ?? 'support@ojas.com',
      supportPhone: json['supportPhone'] ?? '+1 (555) 123-4567',
      footerMessage: json['footerMessage'] ?? '© 2026 OJAS. All rights reserved.',
      logo: json['logo'] ?? '',
      favicon: json['favicon'] ?? '',
      enableAnnouncement: json['enableAnnouncement'] ?? false,
      announcementMessage: json['announcementMessage'] ?? '',
      announcementLink: json['announcementLink'] ?? '',
      contactPhone: json['contactPhone'] ?? '+91 9087654321',
      contactEmail: json['contactEmail'] ?? 'support@ojas.com',
      contactAddress: json['contactAddress'] ?? 'Ghaziabad, Uttar Pradesh',
      returnRefundPolicy: json['returnRefundPolicy'] ?? '',
      termsConditions: json['termsConditions'] ?? '',
      privacyPolicy: json['privacyPolicy'] ?? '',
    );
  }

  static AppSettings defaultSettings() {
    return AppSettings(
      marketplaceName: 'OJAS',
      tagline: 'Where Great Products Meet Happy Customers',
      supportEmail: 'support@ojas.com',
      supportPhone: '+1 (555) 123-4567',
      footerMessage: '© 2026 OJAS. All rights reserved.',
      logo: '',
      favicon: '',
      enableAnnouncement: false,
      announcementMessage: '',
      announcementLink: '',
      contactPhone: '+91 9087654321',
      contactEmail: 'support@ojas.com',
      contactAddress: 'Ghaziabad, Uttar Pradesh',
      returnRefundPolicy: '',
      termsConditions: '',
      privacyPolicy: '',
    );
  }
}
