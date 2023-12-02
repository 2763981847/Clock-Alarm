import hilog from '@ohos.hilog';

class Logger {
  private domain: number;
  private prefix: string;
  private format: string = '%{public}s, %{public}s';

  /**
   * 构造函数。
   *
   * @param prefix 标识日志标签的前缀
   * @param domain 域，表示服务域，范围从 0x0 到 0xFFFFF 的十六进制整数
   */
  constructor(prefix: string = 'AlarmClock', domain: number = 0xFF00) {
    this.prefix = prefix;
    this.domain = domain;
  }

  /**
   * 记录调试级别的日志。
   *
   * @param args 要记录的日志信息
   */
  debug(...args: string[]): void {
    hilog.debug(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录信息级别的日志。
   *
   * @param args 要记录的日志信息
   */
  info(...args: string[]): void {
    hilog.info(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录警告级别的日志。
   *
   * @param args 要记录的日志信息
   */
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.prefix, this.format, args);
  }

  /**
   * 记录错误级别的日志。
   *
   * @param args 要记录的日志信息
   */
  error(...args: string[]): void {
    hilog.error(this.domain, this.prefix, this.format, args);
  }
}

// 创建默认的 Logger 实例并导出
export default new Logger('AlarmClock', 0xFF00);
