import reminderAgent from '@ohos:reminderAgentManager';
export default class ReminderItem {
    constructor() {
        this.id = 0;
        this.remindType = reminderAgent.ReminderType.REMINDER_TYPE_ALARM;
        this.name = '';
        this.hour = 0;
        this.minute = 0;
        this.duration = 0;
        this.intervalMinute = 0;
        this.intervalTimes = 0;
        this.repeatDays = [];
        this.notificationId = 0;
    }
}
//# sourceMappingURL=ReminderItem.js.map