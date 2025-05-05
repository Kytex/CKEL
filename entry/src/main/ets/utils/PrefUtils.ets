import { preferences } from "@kit.ArkData";

export class PrefUtils {
  private static instance: preferences.Preferences;
  static KEY_ACCESS_TOKEN: string = "access_token"
  static KEY_IS_LOGIN = "is_login"
  static KEY_REFRESH_TOKEN = "refreshToken";

  static init(context: Context) {
    PrefUtils.instance = preferences.getPreferencesSync(context, { name: 'global' });
  }

  static isPrivacyAgree() {
    return Boolean(PrefUtils.instance.getSync("isAgree", false))
  }

  static setPrivacyAgree() {
    PrefUtils.instance.putSync("isAgree", true)
    PrefUtils.instance.flush()
  }

  static getAccessToken(): string {
    return PrefUtils.instance.getSync("access_token", "").toString()
  }

  static setAccessToken(token: string) {
    PrefUtils.instance.put("access_token", token)
    PrefUtils.instance.flush()
  }

  static isLogin() {
    return Boolean(PrefUtils.instance.getSync("is_login", false))
  }

  static putString(key: string, value: string) {
    PrefUtils.instance.put(key, value)
    PrefUtils.instance.flush()
  }

  static getString(key: string): string {
    return PrefUtils.instance.getSync(key, "").toString()
  }

  static putBoolean(key: string, value: boolean) {
    PrefUtils.instance.put(key, value)
  }

  static getBoolean(key: string): boolean {
    return Boolean(PrefUtils.instance.getSync(key, false))
  }

  static putNumber(key: string, value: number) {
    PrefUtils.instance.put(key, value)
    PrefUtils.instance.flush()
  }

  static getNumber(key: string): number {
    return Number(PrefUtils.instance.getSync(key, 0))
  }
}