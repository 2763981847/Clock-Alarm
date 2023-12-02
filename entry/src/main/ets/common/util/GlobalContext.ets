/**
 * 全局上下文类，用于在应用程序中共享全局数据和对象。
 */
export class GlobalContext {
  private constructor() {
  }

  private static instance: GlobalContext;
  private _objects = new Map<string, Object>();

  /**
   * 获取全局上下文实例。
   *
   * @return 全局上下文实例
   */
  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  /**
   * 获取指定键对应的对象。
   *
   * @param key 对象的键
   * @return 对应的对象，如果不存在则返回 undefined
   */
  getObject(key: string): Object | undefined {
    return this._objects.get(key);
  }

  /**
   * 设置指定键对应的对象。
   *
   * @param key 对象的键
   * @param objectClass 要设置的对象
   */
  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}
