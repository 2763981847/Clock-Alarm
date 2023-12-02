import ReminderItem from './ReminderItem';

/**
 * Alarm item description.
 */
@Observed export default class AlarmItem extends ReminderItem {
  /**
   * Custom alarm name.
   */
  name = '闹钟';

  /**
   * Custom alarm is open.
   */
  isOpen: boolean = true;

  /**
   * Custom alarm is repeat.
   */
  repeatType: RepeatType = RepeatType.NoRepeat

  /**
   * Custom alarm duration.
   */
  duration: number = 5;

  /**
   * Custom alarm interval minute.
   */
  intervalMinute: number = 10;

  /**
   * Custom alarm interval times.
   */
  intervalTimes: number = 3;
}

export enum RepeatType {
  NoRepeat = '仅一次',
  Everyday = '每天',
  DoubleRest = '双休制',
  SingleRest = '单休制',
  Custom = '自定义',
}