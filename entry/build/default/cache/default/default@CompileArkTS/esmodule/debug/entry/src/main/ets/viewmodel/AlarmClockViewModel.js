import { AlarmClockConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/AlarmClockConstants';
import ReminderService from '@bundle:com.huawei.alarmclock/entry/ets/model/ReminderService';
import { CommonConstants, WeekDays } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import DataTypeUtils from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DataTypeUtils';
import { GlobalContext } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/GlobalContext';
/**
 * Declare class of main view model.
 */
export default class AlarmClockViewModel {
    constructor() {
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
    queryDatabaseAlarms(callback) {
        let preference = GlobalContext.getContext().getObject('preference');
        preference.get(CommonConstants.ALARM_KEY).then((data) => {
            if (!DataTypeUtils.isNull(data)) {
                this.alarms = JSON.parse(data);
                this.alarms.sort((a, b) => a.hour == b.hour ? a.minute - b.minute : a.hour - b.hour);
                callback(this.alarms);
            }
        });
    }
    /**
     * Refresh alarm task.
     *
     * @param callback (alarms: Array<AlarmItem>) => void
     */
    queryAlarmsTasker(callback) {
        let that = this;
        that.queryDatabaseAlarms(callback);
        let preference = GlobalContext.getContext().getObject('preference');
        preference.addPreferencesListener({
            onDataChanged() {
                that.queryDatabaseAlarms(callback);
            }
        });
    }
    disableExpiredReminders() {
        this.reminderService.getValidReminders((remindRequests) => {
            let remindRequestIds = remindRequests.map(remindRequest => remindRequest.notificationId);
            this.alarms
                .filter(alarm => !remindRequestIds.includes(alarm.notificationId) && alarm.isOpen)
                .forEach(alarm => this.openAlarm(alarm.id, false));
        });
    }
    /**
     * Padding zeros for insufficient digits
     *
     * @param val number
     * @return content string
     */
    static fillZero(val) {
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
    getNoonContent(hour) {
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
    getTaskTimeContent(hour, minute) {
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
    getDescContent(alarmItem) {
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
    getAlarmRepeatDayContent(repeatDays) {
        let content = AlarmClockConstants.DEFAULT_STRING_NULL;
        for (let i = 0; i < repeatDays.length; i++) {
            let repeatDay = repeatDays[i];
            let repeatContent = CommonConstants.DEFAULT_STRING_MONDAY;
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
    openAlarm(id, isOpen) {
        for (let i = 0; i < this.alarms.length; i++) {
            if (this.alarms[i].id === id) {
                this.alarms[i].isOpen = isOpen;
                if (isOpen) {
                    this.reminderService.addReminder(this.alarms[i]);
                }
                else {
                    this.reminderService.deleteReminder(this.alarms[i].id);
                }
                let preference = GlobalContext.getContext().getObject('preference');
                preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
                break;
            }
        }
    }
}
AlarmClockViewModel.instant = new AlarmClockViewModel();
//# sourceMappingURL=AlarmClockViewModel.js.map