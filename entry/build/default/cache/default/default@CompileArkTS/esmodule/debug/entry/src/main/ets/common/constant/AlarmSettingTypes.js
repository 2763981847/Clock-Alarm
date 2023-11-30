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
/**
 * Alarm setting type enum description.
 */
export var AlarmSettingTypes;
(function (AlarmSettingTypes) {
    /**
     * Alarm setting type repeat.
     */
    AlarmSettingTypes[AlarmSettingTypes["REPEAT"] = 0] = "REPEAT";
    /**
    * Alarm setting type name.
    */
    AlarmSettingTypes[AlarmSettingTypes["ALARM_NAME"] = 1] = "ALARM_NAME";
    /**
    * Alarm setting type ring duration.
    */
    AlarmSettingTypes[AlarmSettingTypes["RING_DURATION"] = 2] = "RING_DURATION";
    /**
    * Alarm setting type interval.
    */
    AlarmSettingTypes[AlarmSettingTypes["INTERVAL"] = 3] = "INTERVAL";
})(AlarmSettingTypes || (AlarmSettingTypes = {}));
//# sourceMappingURL=AlarmSettingTypes.js.map