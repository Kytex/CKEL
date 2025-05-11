import { LoginInfoModel } from "../beans/LoginInfoModel";
import { LoginModel } from "../beans/LoginModel";
import { UserInfo } from "../beans/UserInfo";
import { AppConst } from "../utils/AppConst";
import { PrefUtils } from "../utils/PrefUtils";
import { bundleManager } from "@kit.AbilityKit";

export class UserHelper {
  static isLogin(): boolean {
    return PrefUtils.getBoolean(PrefUtils.KEY_IS_LOGIN)
  }

  static saveData(model: LoginModel) {
    let accessToken: string = model.accessToken
    let refreshToken: string = model.refreshToken
    PrefUtils.putBoolean(PrefUtils.KEY_IS_LOGIN, true)
    PrefUtils.putBoolean(PrefUtils.KEY_IS_EXECUTIVE, true)
    PrefUtils.putString(PrefUtils.KEY_PARTNERCODE, accessToken)
    PrefUtils.putString(PrefUtils.KEY_APPLY_COMPANY_NAME, accessToken)
    PrefUtils.putString(PrefUtils.KEY_ACCESS_TOKEN, accessToken)
    PrefUtils.putString(PrefUtils.KEY_REFRESH_TOKEN, refreshToken)
    AppConst.accessToken = accessToken
    AppConst.refreshToken = refreshToken
  }

  static saveUserData(userInfo: UserInfo) {
    PrefUtils.putString(PrefUtils.KEY_ACCOUNT, userInfo.userPhone); //以前只有手机号登录，所以ACCOUNT存的是手机号
    PrefUtils.putString(PrefUtils.KEY_USER_EMAIL, userInfo.userEmail); //用户邮箱
    PrefUtils.putString(PrefUtils.KEY_PARTNERCODE, userInfo.partnerCode);
    PrefUtils.putString(PrefUtils.KEY_USER_NAME, userInfo.userName);
    PrefUtils.putString(PrefUtils.KEY_DEPARTMENT_ID, userInfo.departmentId);
    PrefUtils.putString(PrefUtils.KEY_DEPARTMENT_NAME, userInfo.departmentName);
    PrefUtils.putString(PrefUtils.KEY_PHONE, userInfo.userPhone);
    PrefUtils.putString(PrefUtils.KEY_ID, userInfo.userID);
    PrefUtils.putString(PrefUtils.KEY_COMPANY_ID, userInfo.companyID);
    AppConst.companyID = userInfo.companyID;
  }

  static async getLoginInfoModel(data: LoginModel, userInfo: UserInfo): Promise<LoginInfoModel> {
    const bundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT)
    return {
      accessToken: data.accessToken,
      refreshToken: data.refreshToken,
      companyAbbreviate: data.companyAbbreviate,
      isExecutive: data.isExecutive,
      companyName: data.companyName,
      userName: userInfo.userName,
      partnerCode: userInfo.partnerCode,
      type: data.type,
      sign: data.sign,
      code: data.code,
      companyId: data.companyId,
      userCode: data.userCode,
      businessType: data.businessType,
      isH5Back: data.isH5Back,
      isH5Close: data.isH5Close,
      hrCompanyIds: data.hrCompanyIds,
      newApp: false,
      userID: userInfo.userID,
      phone: userInfo.userPhone,
      departmentId: userInfo.departmentId,
      departmentName: userInfo.departmentName,
      companyID: userInfo.companyID,
      accountID: userInfo.accountID,
      userPhone: userInfo.userPhone,
      userEmail: userInfo.userEmail,
      userType: userInfo.userType,
      companyFalg: userInfo.companyFalg,
      appVersion: bundleInfo.versionName,
      appVersionCode: bundleInfo.versionCode
    }
  }
}