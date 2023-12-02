import ReminderItem from './ReminderItem';

/**
 * 闹钟项描述。
 */
@Observed export default class AlarmItem extends ReminderItem {
  /**
   * 闹钟名称。
   */
  name = '闹钟';

  /**
   * 闹钟是否启用。
   */
  isOpen: boolean = true;

  /**
   * 闹钟重复类型。
   */
  repeatType: RepeatType = RepeatType.NoRepeat;

  /**
   * 闹钟持续时间。
   */
  duration: number = 5;

  /**
   * 闹钟间隔时间（分钟）。
   */
  intervalMinute: number = 10;

  /**
   * 闹钟间隔次数。
   */
  intervalTimes: number = 3;
}

/**
 * 用于重复类型的枚举。
 */
export enum RepeatType {
  NoRepeat = '仅一次', // 仅一次
  Everyday = '每天', // 每天
  DoubleRest = '双休制', // 双休制
  SingleRest = '单休制', // 单休制
  Custom = '自定义', // 自定义
}
