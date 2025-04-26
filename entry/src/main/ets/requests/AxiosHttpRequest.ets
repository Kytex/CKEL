import axios, { AxiosInstance, AxiosRequestHeaders } from "@ohos/axios";
import { HttpRequestConfig } from './AxiosHttpSetting';
import { InterceptorHooks } from './AxiosHttpSetting';

/**
 * @ProjectName : multi-nav-bar-master
 * @FileName : AxiosHttpRequest
 * @Author : Chang yuLin
 * @Time : 2024/7/20 15:14
 * @Description : 文件描述
 */
export type CommonType = number | string | boolean | Array<number> | Array<string> | Array<boolean> | object | Object
  | ArrayBuffer

export class AxiosHttpRequest {
  config: HttpRequestConfig;
  interceptorHooks?: InterceptorHooks;
  instance: AxiosInstance;

  constructor(options: HttpRequestConfig) {
    this.config = options;
    this.interceptorHooks = options.interceptorHooks;
    this.instance = axios.create(options);
    this.setupInterceptor()
  }

  setupInterceptor(): void {
    this.instance.interceptors.request.use(
      this.interceptorHooks?.requestInterceptor,
      this.interceptorHooks?.requestInterceptorCatch,
    );

    this.instance.interceptors.response.use(
      this.interceptorHooks?.responseInterceptor,
      this.interceptorHooks?.responseInterceptorCatch,
    );
  }

  // 类型参数的作用，T决定AxiosResponse实例中data的类型
  request<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    return new Promise<T>((resolve, reject) => {
      this.instance
        .request<CommonType, T>(config)
        .then(res => {
          resolve(res);
        })
        .catch((err: CommonType) => {
          //TODO 请求异常处理
          // LogUtils.error("网络请求Request异常：", err.toString())
          // errorHandler(err)
          if (err) {
            reject(err);
          }
        });
    });
  }

  get<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    config.method = 'GET'
   // config.params = "123456"
    return this.request(config);
  }

  post<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    config.method = 'POST'
    return this.request(config);
  }

  delete<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    config.method = 'DELETE'
    return this.request(config);
  }

  patch<T = CommonType>(config: HttpRequestConfig): Promise<T> {
    config.method = 'PATCH'
    return this.request(config);
  }
}


