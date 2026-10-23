enum GrantTypeEnum {
  password('password'),
  refreshToken('refresh_token');

  final String key;
  const GrantTypeEnum(this.key);
}
