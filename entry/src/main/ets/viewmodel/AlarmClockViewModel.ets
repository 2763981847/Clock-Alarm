// 导入所需模块和工具
import { AlarmClockConstants } from '../common/constant/AlarmClockConstants';
import ReminderService from '../model/ReminderService';
import { CommonConstants, WeekDays } from '../common/constant/CommonConstants';
import AlarmItem, { RepeatType } from './AlarmItem';
import DataTypeUtils from '../common/util/DataTypeUtils';
import { GlobalContext } from '../common/util/GlobalContext';
import PreferencesHandler from '../model/database/PreferencesHandler';
import PreferencesListener from '../model/database/PreferencesListener';
import reminderAgentManager from '@ohos.reminderAgentManager';

/**
 * 主视图模型的类声明。
 */
export default class AlarmClockViewModel {
  // 创建一个静态的 AlarmClockViewModel 实例，用于全局访问
  static instant: AlarmClockViewModel = new AlarmClockViewModel();

  // 声明一个 ReminderService 实例，用于管理提醒
  private reminderService: ReminderService;

  // 声明一个存储闹钟项的数组
  private alarms: Array<AlarmItem>;

  // 构造函数，用于初始化成员变量
  private constructor() {
    // 初始化闹钟项数组为空数组
    this.alarms = new Array();
    // 创建 ReminderService 实例
    this.reminderService = new ReminderService();
    // 打开通知权限
    this.reminderService.openNotificationPermission();
    // 禁用已过期的提醒
    this.disableExpiredReminders();
  }

  /**
   * 查询数据库中的闹钟项。
   *
   * @param callback (alarms: Array<AlarmItem>) => void 回调函数，用于处理查询结果
   */
  private queryDatabaseAlarms(callback: (alarms: Array<AlarmItem>) => void) {
    // 获取全局上下文中的 PreferencesHandler 实例
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    // 从数据库中获取闹钟项数据
    preference.get(CommonConstants.ALARM_KEY).then((data: string) => {
      // 如果数据不为空
      if (!DataTypeUtils.isNull(data)) {
        // 解析数据并存储到 alarms 数组中
        this.alarms = JSON.parse(data);
        // 根据小时和分钟排序闹钟项数组
        this.alarms.sort((a, b) => a.hour == b.hour ? a.minute - b.minute : a.hour - b.hour);
        // 调用回调函数，将查询结果传递给调用者
        callback(this.alarms);
      }
    });
  }

  /**
   * 刷新闹钟任务。
   *
   * @param callback (alarms: Array<AlarmItem>) => void 回调函数，用于处理查询结果
   */
  public queryAlarmsTasker(callback: (alarms: Array<AlarmItem>) => void) {
    let that = this;
    // 查询数据库中的闹钟项
    that.queryDatabaseAlarms(callback);
    // 获取全局上下文中的 PreferencesHandler 实例
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    // 添加数据库变化监听器，用于在数据发生变化时刷新闹钟任务
    preference.addPreferencesListener({
      onDataChanged() {
        that.queryDatabaseAlarms(callback);
      }
    } as PreferencesListener);
  }

  /**
   * 禁用已过期的提醒。
   */
  disableExpiredReminders() {
    this.reminderService.getValidReminders(
      (remindRequests: Array<reminderAgentManager.ReminderRequest>) => {
        let remindRequestIds = remindRequests.map(remindRequest => remindRequest.notificationId);
        this.alarms
          .filter(alarm =>!remindRequestIds.includes(alarm.notificationId) && alarm.isOpen)
          .forEach(alarm => this.openAlarm(alarm.id, false));
      }
    );
  }

  /**
   * 为数字填充前导零。
   *
   * @param val number 要填充的数字
   * @return content string 填充后的字符串
   */
  public static fillZero(val: number): string {
    return (val > AlarmClockConstants.DEFAULT_SINGLE_DIGIT_MAX
      ? val.toString()
      : (AlarmClockConstants.DEFAULT_ZEROING + val));
  }

  /**
   * 获取闹钟任务的时间内容。
   *
   * @param hour number 小时
   * @param minute number 分钟
   * @return content string 时间内容字符串
   */
  public getTaskTimeContent(hour: number, minute: number): string {
    return (AlarmClockViewModel.fillZero(hour > CommonConstants.DEFAULT_TOTAL_HOUR ? hour - CommonConstants.DEFAULT_TOTAL_HOUR : hour)
    + AlarmClockConstants.DEFAULT_STRING_COLON
    + AlarmClockViewModel.fillZero(minute));
  }

  /**
   * 获取描述内容。
   *
   * @param alarmItem AlarmItem 闹钟项
   * @return content string 描述内容字符串
   */
  public getDescContent(alarmItem: AlarmItem): string {
    return (alarmItem.name + CommonConstants.DEFAULT_STRING_COMMA
    + (alarmItem.repeatType === RepeatType.Custom
      ? this.getAlarmRepeatDayContent(alarmItem.repeatDays)
      : alarmItem.repeatType));
  }

  /**
   * 获取闹钟任务的重复日期内容。
   *
   * @param repeatDays Array<number> 重复日期数组
   * @return content string 重复日期内容字符串
   */
  public getAlarmRepeatDayContent(repeatDays: Array<number>): string {
    let content = AlarmClockConstants.DEFAULT_STRING_NULL;
    for (let i = 0; i < repeatDays.length; i++) {
      let repeatDay = repeatDays[i];
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
      content += (repeatContent + CommonConstants.DEFAULT_STRING_SPACE);
    }
    return content;
  }

  /**
   * 启用/禁用闹钟。
   *
   * @param id number 闹钟项的 ID
   * @return isOpen boolean 闹钟是否启用
   */
  public openAlarm(id: number, isOpen: boolean) {
    for (let i = 0; i < this.alarms.length; i++) {
      if (this.alarms[i].id === id) {
        this.alarms[i].isOpen = isOpen;
        if (isOpen) {
          this.reminderService.addReminder(this.alarms[i]);
        } else {
          this.reminderService.deleteReminder(this.alarms[i].id);
        }
        // 获取全局上下文中的 PreferencesHandler 实例
        let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
        // 将更新后的闹钟数据保存到数据库
        preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
        break;
      }
    }
  }
}
