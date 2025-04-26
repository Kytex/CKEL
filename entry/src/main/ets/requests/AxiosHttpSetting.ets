import { AxiosRequestHeaders, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { CommonType } from './AxiosHttpRequest';

/**
 * @ProjectName : multi-nav-bar-master
 * @FileName : InterceptorHooks
 * @Author : Chang yuLin
 * @Time : 2024/7/20 15:19
 * @Description : 文件描述
 */
export interface InterceptorHooks {
  // 请求拦截器
  requestInterceptor?: (config: HttpRequestConfig) => Promise<HttpRequestConfig>;
  requestInterceptorCatch?: (error: CommonType) => CommonType;
  // 相应拦截器
  responseInterceptor?: (response: AxiosResponse) => AxiosResponse | Promise<AxiosResponse>;
  responseInterceptorCatch?: (error: CommonType) => CommonType;
}

export interface HttpRequestConfig extends InternalAxiosRequestConfig {
  showLoading?: boolean; //是否展示请求loading
  checkResultCode?: boolean; //是否检验响应结果码
  checkLoginState?: boolean //校验用户登陆状态
  needJumpToLogin?: boolean //是否需要跳转到登陆页面
  interceptorHooks?: InterceptorHooks
  appParams?:CommonType
}
