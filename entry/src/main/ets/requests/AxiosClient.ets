import { AxiosRequestHeaders, AxiosResponse } from '@ohos/axios';
import { errorHandler } from './AxiosErrorHandler';
import { AxiosHttpRequest } from './AxiosHttpRequest';
import { LogUtils } from '../utils/LogUtils';

export const axiosClient = new AxiosHttpRequest({
  baseURL: "/api",
  timeout: 10 * 1000,
  checkResultCode: false,
  headers: getDefaultHeaders() as AxiosRequestHeaders,
  interceptorHooks: {
    requestInterceptor: async (config) => {
      // 在发送请求之前做一些处理，例如打印请求信息
      LogUtils.debug('网络请求Request 请求方法:', `${config.method}`);
      LogUtils.debug('网络请求Request 请求头:', `${config.headers}`);
      LogUtils.debug('网络请求Request 请求url:', `${config.url}`);
      LogUtils.debug('网络请求Request 请求body:', `${config.data}`);
      axiosClient.config.showLoading = config.showLoading
      if (config.showLoading) {
        // showLoadingDialog("加载中...")
      }
      return config;
    },
    requestInterceptorCatch: (err) => {
      LogUtils.error("网络请求RequestError", err.toString())
      if (axiosClient.config.showLoading) {
        // hideLoadingDialog()
      }
      return err;
    },
    responseInterceptor: (response: AxiosResponse) => {
      //优先执行自己的请求响应拦截器，在执行通用请求request的
      if (axiosClient.config.showLoading) {
        // hideLoadingDialog()
      }
      LogUtils.debug('网络请求响应Response:', `\n${JSON.stringify(response.data)}`);
      //let str = JsonUtils.stringify(response.data)
      if (response.status === 200) {
        return Promise.resolve(response.data);
      } else {
        return Promise.reject(response);
      }
    },
    responseInterceptorCatch: (error) => {
      if (axiosClient.config.showLoading) {
        // hideLoadingDialog()
      }
      LogUtils.error("网络请求响应异常", error.toString())
      errorHandler(error);
      return Promise.reject(error);
    },
  }
});

/**
 * 默认头信息
 * @returns
 */
function getDefaultHeaders(): Record<string, string> {
  const headers: Record<string, string> = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Cache-Control": "no-cache",
    "param": headerString()
  };
  return headers;
}

/**
 * 配置头信息
 * @returns
 */
function headerString(): string {
  return "";
}


