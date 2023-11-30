import reminderAgent from '@ohos:reminderAgentManager';
import notification from '@ohos:notificationManager';
import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import Logger from '@bundle:com.huawei.alarmclock/entry/ets/common/util/Logger';
/**
 * Base on ohos reminder agent service
 */
export default class ReminderService {
    /**
     * open notification permission
     */
    openNotificationPermission() {
        notification.requestEnableNotification().then(() => {
            Logger.info('Enable notification success');
        }).catch((err) => {
            Logger.error('Enable notification failed because ' + JSON.stringify(err));
        });
    }
    /**
     * Adding and modifying alarm reminders
     *
     * @param alarmItem ReminderItem
     * @param callback callback
     */
    addReminder(alarmItem, callback) {
        let reminder = this.initReminder(alarmItem);
        reminderAgent.publishReminder(reminder, (_err, reminderId) => {
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
    deleteReminder(reminderId) {
        reminderAgent.cancelReminder(reminderId);
    }
    getValidReminders(callback) {
        reminderAgent.getValidReminders((_err, reminderRequests) => {
            if (callback != null) {
                callback(reminderRequests);
                reminderRequests.forEach((reminderRequest) => reminderRequest.notificationId);
            }
        });
    }
    initReminder(item) {
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
        };
    }
}
//# sourceMappingURL=ReminderService.js.map