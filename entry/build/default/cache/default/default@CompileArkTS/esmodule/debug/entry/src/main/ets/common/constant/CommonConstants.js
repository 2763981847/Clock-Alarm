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
export class CommonConstants {
}
/**
 * database preference id.
 */
CommonConstants.PREFERENCE_ID = 'storageId';
/**
 * database alarm data key.
 */
CommonConstants.ALARM_KEY = 'alarmData';
/**
 * common full length
 */
CommonConstants.FULL_LENGTH = '100%';
/**
 * default string space.
 */
CommonConstants.DEFAULT_STRING_SPACE = ' ';
/**
 * default string comma.
 */
CommonConstants.DEFAULT_STRING_COMMA = '，';
/**
 * default string no repeat.
 */
CommonConstants.DEFAULT_STRING_NO_REPEAT = '仅一次';
/**
 * default number negative.
 */
CommonConstants.DEFAULT_NUMBER_NEGATIVE = -1;
/**
 * default layout weight.
 */
CommonConstants.DEFAULT_LAYOUT_WEIGHT = 1;
/**
 * default single.
 */
CommonConstants.DEFAULT_SINGLE = 1;
/**
 * default double.
 */
CommonConstants.DEFAULT_DOUBLE = 2;
/**
 * default data picker hour selection.
 */
CommonConstants.DEFAULT_DATA_PICKER_HOUR_SELECTION = 2;
/**
 * default total minute.
 */
CommonConstants.DEFAULT_TOTAL_MINUTE = 60;
/**
 * default string monday.
 */
CommonConstants.DEFAULT_STRING_MONDAY = '周一';
/**
 * default string tuesday.
 */
CommonConstants.DEFAULT_STRING_TUESDAY = '周二';
/**
 * default string wednesday.
 */
CommonConstants.DEFAULT_STRING_WEDNESDAY = '周三';
/**
 * default string thursday.
 */
CommonConstants.DEFAULT_STRING_THURSDAY = '周四';
/**
 * default string friday.
 */
CommonConstants.DEFAULT_STRING_FRIDAY = '周五';
/**
 * default string saturday.
 */
CommonConstants.DEFAULT_STRING_SATURDAY = '周六';
/**
 * default string sunday.
 */
CommonConstants.DEFAULT_STRING_SUNDAY = '周日';
/**
 * default number moment.
 */
CommonConstants.DEFAULT_NUMBER_MOMENT = 3;
/**
 * default interval step.
 */
CommonConstants.DEFAULT_INTERVAL_STEP = 5;
/**
 * default common degree
 */
CommonConstants.DEFAULT_COMMON_DEGREE = 6;
/**
 * default pointer width.
 */
CommonConstants.DEFAULT_POINTER_WIDTH = 10;
/**
 * default total hour.
 */
CommonConstants.DEFAULT_TOTAL_HOUR = 12;
/**
 * default interval time max.
 */
CommonConstants.DEFAULT_INTERVAL_TIME_MAX = 10;
/**
 * default interval minute max.
 */
CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX = 30;
/**
 * bundle name.
 */
CommonConstants.BUNDLE_NAME = 'com.huawei.alarmclock';
/**
 * ability name.
 */
CommonConstants.ABILITY_NAME = 'EntryAbility';
CommonConstants.ANIMATION_MEDIUM_DURATION = 500;
CommonConstants.ANIMATION_SHORT_DURATION = 300;
/**
 * Default number for a week.
 */
export var WeekDays;
(function (WeekDays) {
    WeekDays[WeekDays["DEFAULT_NUMBER_MONDAY"] = 1] = "DEFAULT_NUMBER_MONDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_TUESDAY"] = 2] = "DEFAULT_NUMBER_TUESDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_WEDNESDAY"] = 3] = "DEFAULT_NUMBER_WEDNESDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_THURSDAY"] = 4] = "DEFAULT_NUMBER_THURSDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_FRIDAY"] = 5] = "DEFAULT_NUMBER_FRIDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_SATURDAY"] = 6] = "DEFAULT_NUMBER_SATURDAY";
    WeekDays[WeekDays["DEFAULT_NUMBER_SUNDAY"] = 7] = "DEFAULT_NUMBER_SUNDAY";
})(WeekDays || (WeekDays = {}));
//# sourceMappingURL=CommonConstants.js.map