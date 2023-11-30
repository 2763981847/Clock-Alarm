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
import router from '@ohos:router';
import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import { AlarmClockConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/AlarmClockConstants';
import AlarmClockViewModel from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmClockViewModel';
import AlarmList from '@bundle:com.huawei.alarmclock/entry/ets/view/AlarmClock/AlarmList';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
import HeaderContainer from '@bundle:com.huawei.alarmclock/entry/ets/view/HeaderContainer';
import { findNearestAlarmTime } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/AlarmClockUtils';
import NearestAlarmTime from '@bundle:com.huawei.alarmclock/entry/ets/view/AlarmClock/NearestAlarmTime';
export default class AlarmClockPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.intervalId = CommonConstants.DEFAULT_NUMBER_NEGATIVE;
        this.alarmClockModel = AlarmClockViewModel.instant;
        this.__alarmItems = new ObservedPropertyObjectPU(new Array(), this, "alarmItems");
        this.__isAuth = new ObservedPropertySimplePU(false, this, "isAuth");
        this.__nearestAlarmTime = new ObservedPropertyObjectPU(null, this, "nearestAlarmTime");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.intervalId !== undefined) {
            this.intervalId = params.intervalId;
        }
        if (params.alarmClockModel !== undefined) {
            this.alarmClockModel = params.alarmClockModel;
        }
        if (params.alarmItems !== undefined) {
            this.alarmItems = params.alarmItems;
        }
        if (params.isAuth !== undefined) {
            this.isAuth = params.isAuth;
        }
        if (params.nearestAlarmTime !== undefined) {
            this.nearestAlarmTime = params.nearestAlarmTime;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__alarmItems.purgeDependencyOnElmtId(rmElmtId);
        this.__isAuth.purgeDependencyOnElmtId(rmElmtId);
        this.__nearestAlarmTime.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__alarmItems.aboutToBeDeleted();
        this.__isAuth.aboutToBeDeleted();
        this.__nearestAlarmTime.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get alarmItems() {
        return this.__alarmItems.get();
    }
    set alarmItems(newValue) {
        this.__alarmItems.set(newValue);
    }
    get isAuth() {
        return this.__isAuth.get();
    }
    set isAuth(newValue) {
        this.__isAuth.set(newValue);
    }
    get nearestAlarmTime() {
        return this.__nearestAlarmTime.get();
    }
    set nearestAlarmTime(newValue) {
        this.__nearestAlarmTime.set(newValue);
    }
    aboutToAppear() {
        this.alarmClockModel.queryAlarmsTasker((alarms) => {
            Context.animateTo({ duration: CommonConstants.ANIMATION_MEDIUM_DURATION }, () => {
                this.alarmItems = alarms;
                this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems);
            });
        });
        this.intervalId = setInterval(() => {
            this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems);
            this.alarmClockModel.disableExpiredReminders();
        }, AlarmClockConstants.DEFAULT_ONE_SECOND_MS);
    }
    aboutToDisappear() {
        clearInterval(this.intervalId);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width(CommonConstants.FULL_LENGTH);
            Column.height(CommonConstants.FULL_LENGTH);
            Column.backgroundColor({ "id": 16777236, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new HeaderContainer(this, {
                        title: AlarmClockConstants.DEFAULT_STRING_ALARM,
                        closer: () => {
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Row.create({ space: DimensionUtil.getVp({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }) });
                                if (!isInitialRender) {
                                    Row.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Button.createWithChild();
                                Button.stateEffect(false);
                                Button.backgroundColor({ "id": 16777240, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Button.width(DimensionUtil.getVp({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.height(DimensionUtil.getVp({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.onClick(() => {
                                    router.pushUrl({ url: 'pages/DetailIndex' });
                                });
                                if (!isInitialRender) {
                                    Button.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Image.create({ "id": 16777304, "type": 20000, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Image.objectFit(ImageFit.Fill);
                                if (!isInitialRender) {
                                    Image.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            Button.pop();
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Button.createWithChild();
                                Button.stateEffect(false);
                                Button.backgroundColor({ "id": 16777240, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Button.width(DimensionUtil.getVp({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.height(DimensionUtil.getVp({ "id": 16777284, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.onClick(() => {
                                    // todo
                                });
                                if (!isInitialRender) {
                                    Button.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Image.create({ "id": 16777308, "type": 20000, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Image.objectFit(ImageFit.Fill);
                                if (!isInitialRender) {
                                    Image.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            Button.pop();
                            Row.pop();
                        }
                    }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new NearestAlarmTime(this, { nearestAlarmTime: this.__nearestAlarmTime }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new AlarmList(this, { alarmItems: this.__alarmItems }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=AlarmClockPage.js.map