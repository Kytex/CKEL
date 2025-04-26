import { preferences } from "@kit.ArkData";

export class PrefUtils {
  private static instance: preferences.Preferences;

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

  static isFirstIn() {
    return Boolean(PrefUtils.instance.getSync("isFirstIn", true));
  }

  static setIsFirstIn(isFirstIn: boolean) {
    PrefUtils.instance.putSync("isFirstIn", isFirstIn)
    PrefUtils.instance.flush()
  }

  static getAccessToken(): string {
    return PrefUtils.instance.getSync("access_token", "").toString()
  }

  static setAccessToken(token: string) {
    PrefUtils.instance.put("access_token", token)
    PrefUtils.instance.flush()
  }
}