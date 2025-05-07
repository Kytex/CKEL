import { preferences } from "@kit.ArkData";

export class PrefUtils {
  private static instance: preferences.Preferences;
  static KEY_IS_PRIVACY_AGREE = "is_privacy_agree"
  static KEY_IS_FIRST = "is_first"
  static KEY_ACCESS_TOKEN: string = "access_token"
  static KEY_IS_LOGIN = "is_login"
  static KEY_REFRESH_TOKEN = "refreshToken";

  static init(context: Context) {
    PrefUtils.instance = preferences.getPreferencesSync(context, { name: 'global' });
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
    PrefUtils.instance.flush()
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