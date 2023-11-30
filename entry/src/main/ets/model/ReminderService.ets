import reminderAgent from '@ohos.reminderAgentManager';
import notification from '@ohos.notificationManager';
import { CommonConstants } from '../common/constant/CommonConstants';
import ReminderItem from '../viewmodel/ReminderItem';
import Logger from '../common/util/Logger';

/**
 * Base on ohos reminder agent service
 */
export default class ReminderService {
  /**
   * open notification permission
   */
  public openNotificationPermission() {
    notification.requestEnableNotification().then(() => {
      Logger.info('Enable notification success');
    }).catch((err: Error) => {
      Logger.error('Enable notification failed because ' + JSON.stringify(err));
    });
  }

  /**
   * Adding and modifying alarm reminders
   *
   * @param alarmItem ReminderItem
   * @param callback callback
   */
  public addReminder(alarmItem: ReminderItem, callback?: (reminderId: number) => void) {
    let reminder = this.initReminder(alarmItem);
    reminderAgent.publishReminder(reminder, (_err, reminderId: number) => {
      if (callback != null) {
        callback(reminderId);
      }
    });
  }

  /**
   * Adding and modifying alarm reminders
   *
   * @param reminderId number
   */
  public deleteReminder(reminderId: number) {
    reminderAgent.cancelReminder(reminderId);
  }

  public getValidReminders(callback?: (reminderRequests: Array<reminderAgent.ReminderRequest>) => void) {
    reminderAgent.getValidReminders((_err, reminderRequests: Array<reminderAgent.ReminderRequest>) => {
      if (callback != null) {
        callback(reminderRequests);
        reminderRequests.forEach((reminderRequest) => reminderRequest.notificationId)
      }
    })
  }

  private initReminder(item: ReminderItem): reminderAgent.ReminderRequestAlarm {
    return {
      reminderType: item.remindType,
      hour: item.hour,
      minute: item.minute,
      daysOfWeek: item.repeatDays,
      title: item.name,
      ringDuration: item.duration * CommonConstants.DEFAULT_TOTAL_MINUTE,
      snoozeTimes: item.intervalTimes,
      timeInterval: item.intervalMinute * CommonConstants.DEFAULT_TOTAL_MINUTE,
      actionButton: [
        {
          title: '关闭',
          type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_CLOSE
        },
        {
          title: '稍后提醒',
          type: reminderAgent.ActionButtonType.ACTION_BUTTON_TYPE_SNOOZE
        },
      ],
      wantAgent: {
        pkgName: CommonConstants.BUNDLE_NAME,
        abilityName: CommonConstants.ABILITY_NAME
      },
      notificationId: item.notificationId,
      expiredContent: 'this reminder has expired',
      snoozeContent: 'remind later',
      slotType: notification.SlotType.SOCIAL_COMMUNICATION
    }
  }
}