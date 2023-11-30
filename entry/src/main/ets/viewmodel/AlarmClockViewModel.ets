import { AlarmClockConstants } from '../common/constant/AlarmClockConstants';
import ReminderService from '../model/ReminderService';
import { CommonConstants, WeekDays } from '../common/constant/CommonConstants';
import AlarmItem from './AlarmItem';
import DataTypeUtils from '../common/util/DataTypeUtils';
import { GlobalContext } from '../common/util/GlobalContext';
import PreferencesHandler from '../model/database/PreferencesHandler';
import PreferencesListener from '../model/database/PreferencesListener';
import reminderAgent from '@ohos.reminderAgent';
import reminderAgentManager from '@ohos.reminderAgentManager';

/**
 * Declare class of main view model.
 */
export default class AlarmClockViewModel {
  static instant: AlarmClockViewModel = new AlarmClockViewModel();
  private reminderService: ReminderService;
  private alarms: Array<AlarmItem>;

  private constructor() {
    this.alarms = new Array();
    this.reminderService = new ReminderService();
    this.reminderService.openNotificationPermission();
    this.disableExpiredReminders();
  }

  /**
   * Querying alarm task database tables.
   *
   * @param callback (alarms: Array<AlarmItem>) => void
   */
  private queryDatabaseAlarms(callback: (alarms: Array<AlarmItem>) => void) {
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.get(CommonConstants.ALARM_KEY).then((data: string) => {
      if (!DataTypeUtils.isNull(data)) {
        this.alarms = JSON.parse(data);
        this.alarms.sort((a, b) => a.hour == b.hour ? a.minute - b.minute : a.hour - b.hour)
        callback(this.alarms);
      }
    })
  }

  /**
   * Refresh alarm task.
   *
   * @param callback (alarms: Array<AlarmItem>) => void
   */
  public queryAlarmsTasker(callback: (alarms: Array<AlarmItem>) => void) {
    let that = this;
    that.queryDatabaseAlarms(callback);
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    preference.addPreferencesListener({
      onDataChanged() {
        that.queryDatabaseAlarms(callback);
      }
    } as PreferencesListener)
  }

  disableExpiredReminders() {
    this.reminderService.getValidReminders(
      (remindRequests: Array<reminderAgentManager.ReminderRequest>) => {
        let remindRequestIds = remindRequests.map(remindRequest => remindRequest.notificationId)
        this.alarms
          .filter(alarm =>!remindRequestIds.includes(alarm.notificationId) && alarm.isOpen)
          .forEach(alarm => this.openAlarm(alarm.id, false))
      }
    )
  }

  /**
   * Padding zeros for insufficient digits
   *
   * @param val number
   * @return content string
   */
  public static fillZero(val: number): string {
    return (val > AlarmClockConstants.DEFAULT_SINGLE_DIGIT_MAX
      ? val.toString()
      : (AlarmClockConstants.DEFAULT_ZEROING + val));
  }

  /**
   * Get noon content in AlarmClockViewModel.
   *
   * @param hour number
   * @return content string
   */
  public getNoonContent(hour: number): string {
    return (hour < CommonConstants.DEFAULT_TOTAL_HOUR
      ? AlarmClockConstants.DEFAULT_STRING_MORNING
      : AlarmClockConstants.DEFAULT_STRING_AFTERNOON);
  }

  /**
   * Get task time content in AlarmClockViewModel.
   *
   * @param hour number
   * @param minute number
   * @return content string
   */
  public getTaskTimeContent(hour: number, minute: number): string {
    return (AlarmClockViewModel.fillZero(hour > CommonConstants.DEFAULT_TOTAL_HOUR ? hour - CommonConstants.DEFAULT_TOTAL_HOUR : hour)
    + AlarmClockConstants.DEFAULT_STRING_COLON
    + AlarmClockViewModel.fillZero(minute));
  }

  /**
   * Get description content in AlarmClockViewModel.
   *
   * @param alarmItem AlarmItem
   * @return content string
   */
  public getDescContent(alarmItem: AlarmItem): string {
    return (alarmItem.name + CommonConstants.DEFAULT_STRING_COMMA
    + (alarmItem.isRepeat
      ? this.getAlarmRepeatDayContent(alarmItem.repeatDays)
      : CommonConstants.DEFAULT_STRING_NO_REPEAT));
  }

  /**
   * Obtains the number of repetition days of an alarm task.
   *
   * @param repeatDays Array<number>
   * @return content string
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
   * Enabling/Disabling alarms.
   *
   * @param id number
   * @return isOpen boolean
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
        let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
        preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
        break;
      }
    }
  }
}