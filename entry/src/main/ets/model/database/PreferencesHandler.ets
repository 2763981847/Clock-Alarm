import data_preferences from '@ohos.data.preferences';
import { CommonConstants } from '../../common/constant/CommonConstants';
import PreferencesListener from './PreferencesListener';

/**
 * 用户首选项处理器，基于轻量级数据库的数据存储和管理工具。
 */
export default class PreferencesHandler {
  static instance: PreferencesHandler = new PreferencesHandler();
  private preferences: data_preferences.Preferences | null = null;
  private defaultValue = '';
  private listeners: PreferencesListener[];

  private constructor() {
    this.listeners = new Array();
  }

  /**
   * 配置偏好设置处理器，用于初始化用户首选项存储。
   *
   * @param context 上下文对象，提供对应用程序的访问权限
   */
  public async configure(context: Context) {
    this.preferences = await data_preferences.getPreferences(context, CommonConstants.PREFERENCE_ID);
    this.preferences.on('change', (data: Record<string, Object>) => {
      // 当首选项数据发生变化时，通知所有已注册的监听器
      for (let preferencesListener of this.listeners) {
        preferencesListener.onDataChanged(data.key as string);
      }
    });
  }

  /**
   * 在用户首选项中设置键值对数据。
   *
   * @param key 键名
   * @param value 值
   */
  public async set(key: string, value: string) {
    if (this.preferences != null) {
      await this.preferences.put(key, value);
      await this.preferences.flush();
    }
  }

  /**
   * 从用户首选项中获取键对应的值。
   *
   * @param key 键名
   * @return 与键关联的数据值，如果键不存在则返回默认值
   */
  public async get(key: string) {
    let data: string = '';
    if (this.preferences != null) {
      data = await this.preferences.get(key, this.defaultValue) as string;
    }
    return data;
  }

  /**
   * 清除用户首选项中的数据。
   */
  public clear() {
    if (this.preferences != null) {
      this.preferences.clear();
    }
  }

  /**
   * 添加用户首选项变化监听器，以便在数据变化时得到通知。
   *
   * @param listener 偏好设置监听器对象
   */
  public addPreferencesListener(listener: PreferencesListener) {
    this.listeners.push(listener);
  }
}
