import { AxiosRequestHeaders } from '@ohos/axios';
import { UserInfo } from '../beans/UserInfo';
import { UrlConstants } from '../constants/UrlConstants';
import { PrefUtils } from '../utils/PrefUtils';
import { axiosClient } from './AxiosClient';
import { DataResult } from './DataResult';
import { ForgetPwdRequestBody, LoginPostBody } from '../common/customTypes';
import { LoginModel } from '../beans/LoginModel';

export function getUserInfo() {
  return axiosClient.get<DataResult<UserInfo>>({
    url: UrlConstants.API_LOGIN_JAVA + "cuser/getuser",
    showLoading: false,
    headers: defaultHeaders() as AxiosRequestHeaders
  })
}

export function requestLogin(requestBody: LoginPostBody) {
  return axiosClient.post<DataResult<LoginModel>>({
    url: UrlConstants.API_LOGIN_JAVA + "cuser/login",
    showLoading: false,
    headers: defaultHeaders() as AxiosRequestHeaders,
    data: requestBody,
  })
}

//获取验证码
export function getSmsCode(phone: string, answer: string, answerKeyID: string) {
  return axiosClient.get<DataResult<string>>({
    url: UrlConstants.API_LOGIN_JAVA + "cuser/verificationcode/sendLoginMessage?phone=" + phone + "&answer=" + answer +
      "&answerKeyID=" + answerKeyID,
    showLoading: false,
    headers: defaultHeaders() as AxiosRequestHeaders
  })
}

export function defaultHeaders(): Record<string, string> {
  const headers: Record<string, string> = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Cache-Control": "no-cache",
    "Authorization": PrefUtils.getString(PrefUtils.KEY_ACCESS_TOKEN),
    "api-version": "1.1"
  }
  return headers
}

export function headerString(): string {
  return ""
}

export function forgetPwdRequest(requestBody: ForgetPwdRequestBody) {
  return axiosClient.post<DataResult<JSON>>({
    url: UrlConstants.API_LOGIN_JAVA + "cuser/verificationcode/forgetPwd",
    showLoading: false,
    headers: defaultHeaders() as AxiosRequestHeaders,
    data: requestBody
  })
}