import hilog from '@ohos.hilog'

/**
 * 日志工具类
 */
class Logger {
  private domain: number
  private predix: string
  private format: string = '%{public}s, %{public}s'

  /**
   * 构造函数
   * @param prefix 日志Tag
   * @param domain Indicates the service domain, which is a hexadecimal integer ranging from 0x0 to 0xFFFF
   */
  constructor(prefix: string = 'MyApp', domain: number = 0xFF00) {
    this.predix = prefix
    this.domain = domain
  }

  debug(...args: string[]): void {
    hilog.debug(this.domain, this.predix, this.format, args)
  }

  info(...args: string[]): void {
    hilog.info(this.domain, this.predix, this.format, args)
  }

  warn(...args: string[]): void {
    hilog.warn(this.domain, this.predix, this.format, args)
  }

  error(...args: string[]): void {
    hilog.error(this.domain, this.predix, this.format, args)
  }
}

export default new Logger('TargetManagement', 0xFF00)