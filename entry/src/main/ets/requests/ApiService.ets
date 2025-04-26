import { AxiosRequestHeaders } from '@ohos/axios';
import { UserInfo } from '../beans/UserInfo'
import { UrlConstants } from '../constants/UrlConstants';
import { PrefUtils } from '../utils/PrefUtils';
import { axiosClient } from './AxiosClient'
import { DataResult } from './DataResult'

export function getUserInfo() {
  return axiosClient.get<DataResult<UserInfo>>({
    url: UrlConstants.API_LOGIN_JAVA + "cuser/getuser",
    showLoading: false,
    headers: defaultHeaders() as AxiosRequestHeaders
  })
}

export function defaultHeaders(): Record<string, string> {
  const headers: Record<string, string> = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Cache-Control": "no-cache",
    "Authorization": PrefUtils.getAccessToken(),
    "api-version": "1.1"
  }
  return headers
}

export function headerString(): string {
  return ""
}