import { preferences } from "@kit.ArkData";

export class PrefUtils {
  private static instance: preferences.Preferences | null = null;

  static getInstance(context: Context) {
    if (!PrefUtils.instance) {
      PrefUtils.instance = preferences.getPreferencesSync(context, { name: 'global' });
    }
    return PrefUtils.instance;
  }

  static isPrivacyAgree(context: Context) {
    return Boolean(PrefUtils.getInstance(context).getSync("isAgree", false))
  }
}