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
import AlarmItem from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmItem';
import AlarmSettingItem from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmSettingItem';
import { AlarmSettingTypes } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/AlarmSettingTypes';
import { DetailConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/DetailConstants';
import BackContainer from '@bundle:com.huawei.alarmclock/entry/ets/view/BackContainer';
import DetailModel from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/DetailViewModel';
import DatePickArea from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/DatePickArea';
import SettingItem from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/SettingItem';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
import promptAction from '@ohos:promptAction';
import { findNearestAlarmTime, generateNearestAlarmTimeToast } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/AlarmClockUtils';
class DetailIndex extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__alarmItem = new ObservedPropertyObjectPU(new AlarmItem(), this, "alarmItem");
        this.addProvidedVar("onAlarmItemChange", this.__alarmItem);
        this.addProvidedVar("alarmItem", this.__alarmItem);
        this.__repeatSettingArr = new ObservedPropertyObjectPU([], this, "repeatSettingArr");
        this.__alarmSettingInfoArr = new ObservedPropertyObjectPU([], this, "alarmSettingInfoArr");
        this.isNew = true;
        this.viewModel = DetailModel.instant;
        this.setInitiallyProvidedValue(params);
        this.declareWatch("alarmItem", this.onAlarmItemChange);
    }
    setInitiallyProvidedValue(params) {
        if (params.alarmItem !== undefined) {
            this.alarmItem = params.alarmItem;
        }
        if (params.repeatSettingArr !== undefined) {
            this.repeatSettingArr = params.repeatSettingArr;
        }
        if (params.alarmSettingInfoArr !== undefined) {
            this.alarmSettingInfoArr = params.alarmSettingInfoArr;
        }
        if (params.isNew !== undefined) {
            this.isNew = params.isNew;
        }
        if (params.viewModel !== undefined) {
            this.viewModel = params.viewModel;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__repeatSettingArr.purgeDependencyOnElmtId(rmElmtId);
        this.__alarmSettingInfoArr.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__alarmItem.aboutToBeDeleted();
        this.__repeatSettingArr.aboutToBeDeleted();
        this.__alarmSettingInfoArr.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get alarmItem() {
        return this.__alarmItem.get();
    }
    set alarmItem(newValue) {
        this.__alarmItem.set(newValue);
    }
    get repeatSettingArr() {
        return this.__repeatSettingArr.get();
    }
    set repeatSettingArr(newValue) {
        this.__repeatSettingArr.set(newValue);
    }
    get alarmSettingInfoArr() {
        return this.__alarmSettingInfoArr.get();
    }
    set alarmSettingInfoArr(newValue) {
        this.__alarmSettingInfoArr.set(newValue);
    }
    aboutToAppear() {
        let params = router.getParams();
        if (params !== undefined) {
            let alarmItem = params.alarmItem;
            if (alarmItem !== undefined) {
                this.isNew = false;
                this.alarmItem = alarmItem;
                this.viewModel.setAlarmDefaultTime(this.alarmItem);
            }
            else {
                this.viewModel.setAlarmDefaultTime();
            }
        }
        else {
            this.viewModel.setAlarmDefaultTime();
        }
        this.initData();
    }
    onAlarmItemChange() {
        this.initData();
    }
    initData() {
        this.repeatSettingArr = [
            new AlarmSettingItem(DetailConstants.DEFAULT_STRING_REPEAT, this.alarmItem.isRepeat ? DetailConstants.DEFAULT_STRING_REPEAT
                : CommonConstants.DEFAULT_STRING_NO_REPEAT, AlarmSettingTypes.REPEAT)
        ];
        this.alarmSettingInfoArr = [
            new AlarmSettingItem(DetailConstants.DEFAULT_STRING_ALARM_NAME, this.alarmItem.name, AlarmSettingTypes.ALARM_NAME),
            new AlarmSettingItem(DetailConstants.DEFAULT_STRING_DURATION, this.alarmItem.duration + DetailConstants.DEFAULT_STRING_MINUTE, AlarmSettingTypes.RING_DURATION),
            new AlarmSettingItem(DetailConstants.DEFAULT_STRING_INTERVAL, this.alarmItem.intervalMinute
                + DetailConstants.DEFAULT_STRING_MINUTE + CommonConstants.DEFAULT_STRING_COMMA
                + this.alarmItem.intervalTimes + DetailConstants.DEFAULT_STRING_TIMES, AlarmSettingTypes.INTERVAL)
        ];
    }
    pageTransition() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            PageTransition.create();
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 定义页面进入时的效果，从底侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionEnter.create({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION });
            // 定义页面进入时的效果，从底侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionEnter.slide(SlideEffect.Bottom);
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 定义页面退出时的效果，向底侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionExit.create({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION });
            // 定义页面退出时的效果，向底侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionExit.slide(SlideEffect.Bottom);
            ViewStackProcessor.StopGetAccessRecording();
        });
        PageTransition.pop();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.backgroundColor({ "id": 16777236, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            Column.width(CommonConstants.FULL_LENGTH);
            Column.height(CommonConstants.FULL_LENGTH);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new BackContainer(this, {
                        header: this.isNew ? { "id": 16777225, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" } : { "id": 16777232, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" },
                        backImgRes: { "id": 16777305, "type": 20000, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" },
                        closer: () => {
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Button.createWithChild();
                                Button.backgroundColor({ "id": 16777240, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Button.width(DimensionUtil.getVp({ "id": 16777299, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.height(DimensionUtil.getVp({ "id": 16777299, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                Button.onClick(() => {
                                    this.viewModel.setAlarmRemind(ObservedObject.GetRawObject(this.alarmItem));
                                    let nextAlarmTime = findNearestAlarmTime([this.alarmItem]);
                                    promptAction.showToast({
                                        message: generateNearestAlarmTimeToast(nextAlarmTime)
                                    });
                                    router.back();
                                });
                                if (!isInitialRender) {
                                    Button.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                Image.create({ "id": 16777307, "type": 20000, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                Image.objectFit(ImageFit.Fill);
                                if (!isInitialRender) {
                                    Image.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            Button.pop();
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
                    ViewPU.create(new DatePickArea(this, {}, undefined, elmtId));
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
                    ViewPU.create(new SettingItem(this, {
                        settingInfo: this.__repeatSettingArr
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
                    ViewPU.create(new SettingItem(this, {
                        settingInfo: this.__alarmSettingInfoArr
                    }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Blank.create();
            if (!isInitialRender) {
                Blank.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Blank.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Button.createWithLabel({ "id": 16777223, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            Button.visibility(this.isNew ? Visibility.None : Visibility.Visible);
            Button.width(DimensionUtil.getVp({ "id": 16777270, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Button.height(DimensionUtil.getVp({ "id": 16777267, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Button.fontSize(DimensionUtil.getFp({ "id": 16777266, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Button.fontColor({ "id": 16777239, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            Button.backgroundColor({ "id": 16777238, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            Button.borderRadius(DimensionUtil.getVp({ "id": 16777269, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Button.margin({
                bottom: DimensionUtil.getVp({ "id": 16777268, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
            });
            Button.onClick(() => {
                this.viewModel.removeAlarmRemind(this.alarmItem.id);
                router.back();
            });
            if (!isInitialRender) {
                Button.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Button.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new DetailIndex(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=DetailIndex.js.map