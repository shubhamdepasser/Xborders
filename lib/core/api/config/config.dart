class Config {
  static const String BASE_URl = 'https://cc.xborders.in';
  static const String loginUrl = '/api/user/login.json';
  static String requestToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJpdGwtaW50bC1hcHAuaXRoaW5rbG9naXN0aWNzLmNvbSIsImF1ZCI6Iml0bC1pbnRsLWFwcC5pdGhpbmtsb2dpc3RpY3MuY29tIiwiaWF0IjoxNjQ0ODI1MDQ3LCJuYmYiOjE2NDQ4MjUwNDcsImV4cCI6MTY0NDg2ODI0NywiZGF0YSI6eyJpc19sb2dpbiI6IjEiLCJsb2dnZWRpbl91c2VyX3R5cGUiOiI0IiwibG9nZ2VkaW5fdXNlcl9pZCI6IjQiLCJsb2dnZWRpbl91c2VyX2ZpcnN0X25hbWUiOiJLdWxkZWVwIiwibG9nZ2VkaW5fdXNlcl9sYXN0X25hbWUiOiJQYXRlbCIsImxvZ2dlZGluX3VzZXJfZW1haWwiOiJrdWxkZWVwQGdtYWlsLmNvbSIsImxvZ2dlZGluX3VzZXJfbW9iaWxlIjoiOTg3NjU0MzIxMCIsImxvZ2dlZGluX3VzZXJfc2hvd19hbGxfdmVuZG9ycyI6IjAiLCJsb2dnZWRpbl91c2VyX3VzZXJfaWRfbGlzdCI6IiIsImlzX3ZlbmRvcl9zdWJfYWRtaW4iOiIwIiwidmVuZG9yX3N1Yl9hZG1pbl91c2VyX2lkIjoiIiwidmVuZG9yX2FkbWluX3VzZXJfaWQiOiIwIiwibG9nZ2VkaW5fb25ib2FyZF91c2VyIjoiMCIsImxvZ2dlZGluX29uYm9hcmRfdXNlcl9pZCI6IjAiLCJsb2dnZWRpbl91c2VyX2RjX2lkIjoiMSJ9fQ.ecEVqdMd26-B1HJonbVFReektHaRprFwmeTRnDWvsyc3f4b_-xDLnKPBJK2Z2UjVayiazvGCrwMjxL9J9Ac5wXmJ8S3ygyg2q5bMmTDDRKjTeHcMyXbC3YWh3XN-ajQwsl6gswtSmSx7osLlHhbbLjzBpLuzNSm13O4xbHkkx5dyeFc8fWNFsRbxcvuaZn4PFBdkwqHLeNKyZTl4heZWfIHpYyJp0o5DVMZkUQ6eHBzf0gmRFjzPFW98bhVSGZP0DsJXZ_barY_uuRowYqlGAB8t69Cir9DJ-yEPYb4z9W0GO9gBccItXJlAIn4GchdQ4E_MZPQn3WvFfh6JfK3Ozg';
  static const String invardscan = '/api/scan/scan_details.json';
  static String userId = 'user_id';
  static String awb = '';
  static String customer_invoice = '';
  static String omid = '';
   static String omrowid = '';

  //reprint

  static const String Reprintscan = '/api/reprint-scan/get.json';
  static const String Reprintscandamage =
      '/api/reprint-scan/update_damage.json';
  static const String GetWddetails = '/api/reprint-scan/get_wd.json';
  static const String updateWD = '/api/reprint-scan/update_wd.json';
  static const String printdocument = '/api/reprint-scan/print.json';
  static const String uploadimage = '/api/reprint-scan/upload.json';

  static const String imagebase64 = '';
}

//hwab
class Configg {
  static const String bagdetails = '/api/bag/get.json';
  static const String createbag = '/api/bag/create.json';
  static const String getbag = '/api/bag/get.json';
  static const String submit = '/api/bag/update.json';
  static const String unload = '/api/bag/unload.json';
  static const String pdf = '/api/bag/print.json';
  static const String load = '/api/bag/load.json';
  static String userId = 'user_id';
  static String lastmile = '';
  static String bagmessage = '';
  static String printer = '';
}
