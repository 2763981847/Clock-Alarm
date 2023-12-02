import { AlarmSettingTypes } from '../common/constant/AlarmSettingTypes';

/**
 * 闹钟设置项信息。
 */
export default class AlarmSettingItem {
  /**
   * 闹钟设置标题。
   */
  public title: string;
  /**
   * 闹钟设置内容。
   */
  public content: string;
  /**
   * 闹钟设置类型。
   */
  public sType: AlarmSettingTypes;

  constructor(title: string, content: string, sType: AlarmSettingTypes) {
    this.title = title;
    this.content = content;
    this.sType = sType;
  }
}
