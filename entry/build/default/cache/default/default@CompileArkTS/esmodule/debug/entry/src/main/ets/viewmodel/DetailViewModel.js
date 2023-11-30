/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { DetailConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/DetailConstants';
import { CommonConstants, WeekDays } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import ReminderService from '@bundle:com.huawei.alarmclock/entry/ets/model/ReminderService';
import DataTypeUtils from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DataTypeUtils';
import { GlobalContext } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/GlobalContext';
/**
 * Detail page view model description
 */
export default class DetailViewModel {
    constructor() {
        this.reminderService = new ReminderService();
        this.alarms = new Array();
    }
    /**
     * Conversion alarm repeat day content
     *
     * @param repeatDay number
     * @return repeatContent string
     */
    transAlarmRepeatDayContent(repeatDay) {
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
        return repeatContent;
    }
    /**
     * Set the initial time of the alarm.
     *
     * @param alarmItem AlarmItem
     */
    setAlarmDefaultTime(alarmItem) {
        let hour;
        let minute;
        if (alarmItem == null) {
            let date = new Date();
            hour = date.getHours();
            minute = date.getMinutes();
        }
        else {
            hour = alarmItem.hour;
            minute = alarmItem.minute;
        }
        DetailConstants.DAY_DATA[0].delSelect = (hour >= CommonConstants.DEFAULT_TOTAL_HOUR
            ? CommonConstants.DEFAULT_SINGLE
            : 0);
        DetailConstants.DAY_DATA[CommonConstants.DEFAULT_SINGLE].delSelect = (hour === 0
            ? CommonConstants.DEFAULT_TOTAL_HOUR
            : (hour > CommonConstants.DEFAULT_TOTAL_HOUR ? hour - CommonConstants.DEFAULT_TOTAL_HOUR : hour))
            - CommonConstants.DEFAULT_SINGLE;
        DetailConstants.DAY_DATA[CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION].delSelect =
            (minute === 0 ? CommonConstants.DEFAULT_TOTAL_MINUTE : minute) - CommonConstants.DEFAULT_SINGLE;
    }
    /**
     * Set the alarm remind.
     *
     * @param alarmItem AlarmItem
     */
    async setAlarmRemind(alarmItem) {
        alarmItem.hour = this.getAlarmTime(CommonConstants.DEFAULT_SINGLE);
        alarmItem.minute = this.getAlarmTime(CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION);
        let index = await this.findAlarmWithId(alarmItem.id);
        if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
            this.reminderService.deleteReminder(alarmItem.id);
        }
        else {
            index = this.alarms.length;
            alarmItem.notificationId = index;
            this.alarms.push(alarmItem);
        }
        this.reminderService.addReminder(alarmItem, (newId) => {
            alarmItem.id = newId;
            alarmItem.isOpen = true;
            this.alarms[index] = alarmItem;
            let preference = GlobalContext.getContext().getObject('preference');
            preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
        });
    }
    /**
     * Remove the alarm remind.
     *
     * @param id number
     */
    async removeAlarmRemind(id) {
        this.reminderService.deleteReminder(id);
        let index = await this.findAlarmWithId(id);
        if (index !== CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
            this.alarms.splice(index, CommonConstants.DEFAULT_SINGLE);
        }
        let preference = GlobalContext.getContext().getObject('preference');
        preference.set(CommonConstants.ALARM_KEY, JSON.stringify(this.alarms));
    }
    getAlarmTime(aType) {
        let times = DetailConstants.DAY_DATA[aType];
        let selectedIndex = times.delSelect;
        let time = Number(times.data[selectedIndex]);
        if (aType === CommonConstants.DEFAULT_SINGLE) {
            time = (time === CommonConstants.DEFAULT_TOTAL_HOUR ? 0 : time)
                + (DetailConstants.DAY_DATA[0].delSelect === CommonConstants.DEFAULT_SINGLE
                    ? CommonConstants.DEFAULT_TOTAL_HOUR
                    : 0);
        }
        return time;
    }
    async findAlarmWithId(id) {
        let preference = GlobalContext.getContext().getObject('preference');
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
DetailViewModel.instant = new DetailViewModel();
//# sourceMappingURL=DetailViewModel.js.map