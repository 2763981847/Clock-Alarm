/**
 * 用户首选项监听器接口。
 */
export default interface PreferencesListener {
  /**
   * 当用户首选项数据发生变化时的回调函数。
   *
   * @param key 发生变化的键名（可选）
   */
  onDataChanged: (key?: string) => void;
}
