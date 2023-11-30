var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
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
import ReminderItem from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/ReminderItem';
/**
 * Alarm item description.
 */
let AlarmItem = class AlarmItem extends ReminderItem {
    constructor() {
        super(...arguments);
        /**
         * Custom alarm name.
         */
        this.name = '闹钟';
        /**
         * Custom alarm is open.
         */
        this.isOpen = true;
        /**
         * Custom alarm is repeat.
         */
        this.isRepeat = false;
        /**
         * Custom alarm duration.
         */
        this.duration = 5;
        /**
         * Custom alarm interval minute.
         */
        this.intervalMinute = 10;
        /**
         * Custom alarm interval times.
         */
        this.intervalTimes = 3;
    }
};
AlarmItem = __decorate([
    Observed
], AlarmItem);
export default AlarmItem;
//# sourceMappingURL=AlarmItem.js.map