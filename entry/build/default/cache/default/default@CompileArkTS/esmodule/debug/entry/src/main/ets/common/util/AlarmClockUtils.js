export function generateNearestAlarmTimeToast(nextAlarmTime) {
    if (nextAlarmTime.days === 0 && nextAlarmTime.hours === 0 && nextAlarmTime.minutes === 0) {
        return "闹钟将在1分钟之内提醒";
    }
    return `闹钟将在  ${nextAlarmTime.days === 0 ? '' : nextAlarmTime.days + ' 天 '}${nextAlarmTime.hours === 0 ? '' : nextAlarmTime.hours + ' 小时 '}${nextAlarmTime.minutes === 0 ? '' : nextAlarmTime.minutes + ' 分钟 '}后提醒`;
}
export function findNearestAlarmTime(alarmItems) {
    if (!alarmItems || alarmItems.length === 0)
        return null;
    let now = new Date();
    let minimumTimeDiff = Infinity;
    let openedAlarms = alarmItems.filter(alarm => alarm.isOpen);
    if (!openedAlarms || openedAlarms.length === 0)
        return null;
    openedAlarms.map(alarm => getNextAlarmTime(alarm))
        .forEach(nextAlarmTime => {
        let timeDiff = nextAlarmTime.getTime() - now.getTime();
        if (timeDiff >= 0 && timeDiff < minimumTimeDiff) {
            minimumTimeDiff = timeDiff;
        }
    });
    let days = Math.floor(minimumTimeDiff / (1000 * 60 * 60 * 24));
    let hours = Math.floor((minimumTimeDiff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((minimumTimeDiff % (1000 * 60 * 60)) / (1000 * 60));
    return { days: days, hours: hours, minutes: minutes };
}
export function getNextAlarmTime(alarm) {
    // 根据 alarm 的具体属性计算下一个响铃时间
    let now = new Date();
    let nextAlarmDate = new Date(now.getFullYear(), now.getMonth(), now.getDate(), alarm.hour, alarm.minute);
    if (!alarm.isRepeat) {
        // 如果不重复，检查是否已经过了今天的响铃时间
        if (nextAlarmDate < now) {
            // 如果已经过了，设置为明天
            nextAlarmDate.setDate(nextAlarmDate.getDate() + 1);
        }
    }
    else {
        // 如果重复，找到下一个响铃的日子离今天有多远
        let currentDay = now.getDay();
        let daysToAdd = alarm.repeatDays
            .map(day => day == currentDay && nextAlarmDate < now ? 7 : (day - currentDay + 7) % 7) // 计算每个重复日到今天的天数差
            .reduce((min, cur) => Math.min(min, cur)); // 找到最小的天数差
        nextAlarmDate.setDate(now.getDate() + daysToAdd);
    }
    return nextAlarmDate;
}
//# sourceMappingURL=AlarmClockUtils.js.map