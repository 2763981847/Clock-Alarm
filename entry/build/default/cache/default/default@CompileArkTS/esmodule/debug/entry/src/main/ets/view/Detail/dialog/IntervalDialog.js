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
import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import { DetailConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/DetailConstants';
import CommonDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/CommonDialog';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
export default class IntervalDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__alarmItem = this.initializeConsume("alarmItem", "alarmItem");
        this.__intervalMinuteSelect = new ObservedPropertySimplePU(0, this, "intervalMinuteSelect");
        this.__intervalTimesSelect = new ObservedPropertySimplePU(0, this, "intervalTimesSelect");
        this.controller = undefined;
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.intervalMinuteSelect !== undefined) {
            this.intervalMinuteSelect = params.intervalMinuteSelect;
        }
        if (params.intervalTimesSelect !== undefined) {
            this.intervalTimesSelect = params.intervalTimesSelect;
        }
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__intervalMinuteSelect.purgeDependencyOnElmtId(rmElmtId);
        this.__intervalTimesSelect.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__alarmItem.aboutToBeDeleted();
        this.__intervalMinuteSelect.aboutToBeDeleted();
        this.__intervalTimesSelect.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get alarmItem() {
        return this.__alarmItem.get();
    }
    set alarmItem(newValue) {
        this.__alarmItem.set(newValue);
    }
    get intervalMinuteSelect() {
        return this.__intervalMinuteSelect.get();
    }
    set intervalMinuteSelect(newValue) {
        this.__intervalMinuteSelect.set(newValue);
    }
    get intervalTimesSelect() {
        return this.__intervalTimesSelect.get();
    }
    set intervalTimesSelect(newValue) {
        this.__intervalTimesSelect.set(newValue);
    }
    setController(ctr) {
        this.controller = ctr;
    }
    aboutToAppear() {
        this.intervalMinuteSelect = this.alarmItem.intervalMinute;
        this.intervalTimesSelect = this.alarmItem.intervalTimes;
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Flex.create();
            if (!isInitialRender) {
                Flex.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if ((this.intervalTimesSelect | this.intervalMinuteSelect) > 0) {
                this.ifElseBranchUpdateFunction(0, () => {
                    {
                        this.observeComponentCreation((elmtId, isInitialRender) => {
                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                            if (isInitialRender) {
                                ViewPU.create(new CommonDialog(this, {
                                    title: { "id": 16777229, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" },
                                    controller: this.controller,
                                    onConfirm: () => {
                                        this.alarmItem.intervalMinute = Number(this.intervalMinuteSelect.toFixed(0));
                                        this.alarmItem.intervalTimes = Number(this.intervalTimesSelect.toFixed(0));
                                    },
                                    closer: () => {
                                        this.IntervalItem.bind(this)({ "id": 16777230, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }, 0);
                                        this.observeComponentCreation((elmtId, isInitialRender) => {
                                            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                            Divider.create();
                                            Divider.opacity({ "id": 16777272, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                            Divider.color({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                            Divider.lineCap(LineCapStyle.Round);
                                            if (!isInitialRender) {
                                                Divider.pop();
                                            }
                                            ViewStackProcessor.StopGetAccessRecording();
                                        });
                                        this.IntervalItem.bind(this)({ "id": 16777231, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }, CommonConstants.DEFAULT_SINGLE);
                                    }
                                }, undefined, elmtId));
                            }
                            else {
                                this.updateStateVarsOfChildByElmtId(elmtId, {});
                            }
                            ViewStackProcessor.StopGetAccessRecording();
                        });
                    }
                });
            }
            else {
                If.branchId(1);
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        Flex.pop();
    }
    IntervalItem(title, intervalType, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(title);
            Text.fontSize(DimensionUtil.getFp({ "id": 16777281, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Text.width(CommonConstants.FULL_LENGTH);
            Text.textAlign(TextAlign.Start);
            Text.margin({
                top: DimensionUtil.getVp({ "id": 16777282, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
            });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.width(CommonConstants.FULL_LENGTH);
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Slider.create({
                value: (intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect),
                min: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : 0),
                max: (intervalType === 0
                    ? CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX
                    : CommonConstants.DEFAULT_INTERVAL_TIME_MAX),
                step: (intervalType === 0 ? CommonConstants.DEFAULT_INTERVAL_STEP : CommonConstants.DEFAULT_DOUBLE),
                style: SliderStyle.OutSet
            });
            Slider.blockColor(Color.Blue);
            Slider.trackColor(Color.Gray);
            Slider.selectedColor(Color.Blue);
            Slider.showSteps(true);
            Slider.showTips(false);
            Slider.onChange((value) => {
                if (intervalType === 0) {
                    this.intervalMinuteSelect = value;
                }
                else {
                    this.intervalTimesSelect = value;
                }
            });
            if (!isInitialRender) {
                Slider.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create((intervalType === 0 ? this.intervalMinuteSelect : this.intervalTimesSelect).toFixed(0));
            Text.fontSize(DimensionUtil.getFp({ "id": 16777280, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=IntervalDialog.js.map