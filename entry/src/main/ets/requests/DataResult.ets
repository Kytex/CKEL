/**
 * @ProjectName : multi-nav-bar-master
 * @FileName : DataResult
 * @Author : Chang yuLin
 * @Time : 2024/7/20 14:35
 * @Description : 文件描述
 */
export class DataResult<T> {
  code: number = 0
  text: string = ""
  ext: T | null = null
}

