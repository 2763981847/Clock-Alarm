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
import DetailModel from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/DetailViewModel';
import CommonDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/CommonDialog';
import DataTypeUtils from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DataTypeUtils';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
export default class RepeatDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__alarmItem = this.initializeConsume("alarmItem", "alarmItem");
        this.viewModel = DetailModel.instant;
        this.selects = [];
        this.controller = new CustomDialogController({
            builder: () => {
                let jsDialog = new RepeatDialog(this, {});
                jsDialog.setController(this.controller);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.viewModel !== undefined) {
            this.viewModel = params.viewModel;
        }
        if (params.selects !== undefined) {
            this.selects = params.selects;
        }
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        this.__alarmItem.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get alarmItem() {
        return this.__alarmItem.get();
    }
    set alarmItem(newValue) {
        this.__alarmItem.set(newValue);
    }
    setController(ctr) {
        this.controller = ctr;
    }
    aboutToAppear() {
        this.selects = DataTypeUtils.deepCopy(this.alarmItem.repeatDays);
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
        {
            this.observeComponentCreation((elmtId, isInitialRender) => {
                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                if (isInitialRender) {
                    ViewPU.create(new CommonDialog(this, {
                        title: { "id": 16777227, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" },
                        controller: this.controller,
                        onConfirm: () => {
                            this.selects.sort();
                            this.alarmItem.repeatDays = this.selects;
                            this.alarmItem.isRepeat = this.selects.length > 0;
                        },
                        closer: () => {
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                ForEach.create();
                                const forEachItemGenFunction = _item => {
                                    const item = _item;
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
                                        Text.create(this.viewModel.transAlarmRepeatDayContent(item));
                                        Text.layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT);
                                        Text.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                                        Text.fontSize(DimensionUtil.getFp({ "id": 16777288, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                        if (!isInitialRender) {
                                            Text.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Text.pop();
                                    this.observeComponentCreation((elmtId, isInitialRender) => {
                                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                        Checkbox.create({ name: item.toString() });
                                        Checkbox.select(this.alarmItem.repeatDays.indexOf(item) !== CommonConstants.DEFAULT_NUMBER_NEGATIVE);
                                        Checkbox.width(DimensionUtil.getVp({ "id": 16777287, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                        Checkbox.height(DimensionUtil.getVp({ "id": 16777287, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                                        Checkbox.onChange((value) => {
                                            if (value) {
                                                this.selects.push(item);
                                            }
                                            else {
                                                let index = this.selects.indexOf(item);
                                                this.selects.splice(index, CommonConstants.DEFAULT_SINGLE);
                                            }
                                        });
                                        if (!isInitialRender) {
                                            Checkbox.pop();
                                        }
                                        ViewStackProcessor.StopGetAccessRecording();
                                    });
                                    Checkbox.pop();
                                    Row.pop();
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
                                };
                                this.forEachUpdateFunction(elmtId, DetailConstants.WEEKDAY_DATA, forEachItemGenFunction);
                                if (!isInitialRender) {
                                    ForEach.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
                            ForEach.pop();
                        }
                    }, undefined, elmtId));
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {});
                }
                ViewStackProcessor.StopGetAccessRecording();
            });
        }
        Flex.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=RepeatDialog.js.map