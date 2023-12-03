/**
 * 基于 Ohos 提醒代理服务的提醒服务类。
 */
import reminderAgent from '@ohos.reminderAgentManager';
import { CommonConstants } from '../common/constant/CommonConstants';
import ReminderItem from '../viewmodel/ReminderItem';
import notification from '@ohos.notificationManager';
import Logger from '../common/util/Logger';
import DataTypeUtils from '../common/util/DataTypeUtils';

export default class ReminderService {
  /**
   * 请求开启通知权限。
   */
  public openNotificationPermission() {
    notification.requestEnableNotification().then(() => {
      Logger.info('开启通知权限成功');
    }).catch((err: Error) => {
      Logger.error('开启通知权限失败，原因：' + JSON.stringify(err));
    });
  }

  /**
   * 添加或修改提醒。
   *
   * @param alarmItem ReminderItem
   * @param callback 回调函数，可选参数，用于返回提醒的 ID
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
   * 删除提醒。
   *
   * @param reminderId number 提醒的 ID
   */
  public deleteReminder(reminderId: number) {
    reminderAgent.cancelReminder(reminderId);
  }

  /**
   * 获取有效的提醒列表。
   *
   * @param callback 回调函数，可选参数，用于返回有效提醒的列表
   */
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
      daysOfWeek: DataTypeUtils.deepCopy(item.repeatDays),
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
      expiredContent: '该提醒已过期',
      snoozeContent: '稍后提醒',
      slotType: notification.SlotType.SOCIAL_COMMUNICATION
    }
  }
}
