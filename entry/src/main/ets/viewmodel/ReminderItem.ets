import reminderAgent from '@ohos.reminderAgentManager';

/**
 * 提醒项描述。
 */
export default class ReminderItem {
  id: number = 0; // 提醒项唯一标识符
  remindType: reminderAgent.ReminderType = reminderAgent.ReminderType.REMINDER_TYPE_ALARM; // 提醒类型，默认为闹钟
  name: string = ''; // 提醒项名称
  hour: number = 0; // 提醒小时
  minute: number = 0; // 提醒分钟
  duration: number = 0; // 提醒持续时间
  intervalMinute: number = 0; // 提醒间隔时间（分钟）
  intervalTimes: number = 0; // 提醒间隔次数
  repeatDays: Array<number> = []; // 重复的日期（星期几）
  notificationId: number = 0; // 提醒通知的唯一标识符
}
