import { DetailConstants } from '../common/constant/DetailConstants';
import { CommonConstants, WeekDays } from '../common/constant/CommonConstants';
import AlarmItem from './AlarmItem';
import ReminderService from '../model/ReminderService';
import DataTypeUtils from '../common/util/DataTypeUtils';
import { GlobalContext } from '../common/util/GlobalContext';
import PreferencesHandler from '../model/database/PreferencesHandler';
import DayDataItem from './DayDataItem';

/**
 * 详细页面视图模型描述
 */
export default class DetailViewModel {
  static instant: DetailViewModel = new DetailViewModel();
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  private constructor() {
    this.reminderService = new ReminderService();
    this.alarms = new Array<AlarmItem>();
  }

  /**
   * 转换闹钟重复日期的内容
   *
   * @param repeatDay number
   * @return repeatContent string
   */
  public transAlarmRepeatDayContent(repeatDay: number): string {
    let repeatContent: string = CommonConstants.DEFAULT_STRING_MONDAY;
    switch (repeatDay) {
      case WeekDays.DEFAULT_NUMBER_MONDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_MONDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_TUESDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_TUESDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_WEDNESDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_WEDNESDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_THURSDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_THURSDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_FRIDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_FRIDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_SATURDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_SATURDAY;
        break;
      case WeekDays.DEFAULT_NUMBER_SUNDAY:
        repeatContent = CommonConstants.DEFAULT_STRING_SUNDAY;
        break;
      default:
        break;
    }
    return repeatContent;
  }

  /**
   * 设置闹钟的默认时间。
   *
   * @param alarmItem AlarmItem
   */
  public setAlarmDefaultTime(alarmItem?: AlarmItem) {
    let hour: number;
    let minute: number;
    if (alarmItem == null) {
      let date = new Date();
      hour = date.getHours();
      minute = date.getMinutes();
    } else {
      hour = alarmItem.hour;
      minute = alarmItem.minute;
    }
    DetailConstants.DAY_DATA[0].delSelect = hour;
    DetailConstants.DAY_DATA[1].delSelect = minute;
  }

  /**
   * 设置闹钟提醒。
   *
   * @param alarmItem AlarmItem
   */
  public async setAlarmRemind(alarmItem: AlarmItem) {
    alarmItem.hour = this.getAlarmTime(0);
    alarmItem.minute = this.getAlarmTime(1);
    let index = await this.findAlarmWithId(alarmItem.id);
    if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
      this.reminderService.deleteReminder(alarmItem.id);
    } else {
      index = this.alarms.length;
      alarmItem.notificationId = index;
      this.alarms.push(alarmItem);
    }
    this.reminderService.addReminder(alarmItem, (newId: number) => {
      alarmItem.id = newId;
      alarmItem.isOpen = true;
      this.alarms[index] = alarmItem;
      let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
      preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
    });
  }

  /**
   * 移除闹钟提醒。
   *
   * @param id number
   */
  public async removeAlarmRemind(id: number) {
    this.reminderService.deleteReminder(id);
    let index = await this.findAlarmWithId(id);
    if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
      this.alarms.splice(index, CommonConstants.DEFAULT_SINGLE);
    }
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
  }

  private getAlarmTime(aType: number): number {
    let times: DayDataItem = DetailConstants.DAY_DATA[aType];
    let selectedIndex = times.delSelect;
    let time = Number(times.data[selectedIndex]);
    return time;
  }

  private async findAlarmWithId(id: number) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    let data = await preference.get(CommonConstants.ALARM_KEY);
    if (!DataTypeUtils.isNull(data)) {
      this.alarms = JSON.parse(data);
      for (let i = 0; i < this.alarms.length; i++) {
        if (this.alarms[i].id === id) {
          return i;
        }
      }
    }
    return CommonConstants.DEFAULT_NUMBER_NEGATIVE;
  }
}
