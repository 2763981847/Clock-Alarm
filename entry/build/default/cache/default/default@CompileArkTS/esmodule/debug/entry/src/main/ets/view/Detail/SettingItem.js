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
import { AlarmSettingTypes } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/AlarmSettingTypes';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
import IntervalDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/IntervalDialog';
import DurationDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/DurationDialog';
import RenameDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/RenameDialog';
import RepeatDialog from '@bundle:com.huawei.alarmclock/entry/ets/view/Detail/dialog/RepeatDialog';
export default class SettingItem extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__settingInfo = new SynchedPropertyObjectTwoWayPU(params.settingInfo, this, "settingInfo");
        this.repeatDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new RepeatDialog(this, {});
                jsDialog.setController(this.repeatDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.reNameDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new RenameDialog(this, {});
                jsDialog.setController(this.reNameDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.durationDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new DurationDialog(this, {});
                jsDialog.setController(this.durationDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.intervalDialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new IntervalDialog(this, {});
                jsDialog.setController(this.intervalDialogController);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.repeatDialogController !== undefined) {
            this.repeatDialogController = params.repeatDialogController;
        }
        if (params.reNameDialogController !== undefined) {
            this.reNameDialogController = params.reNameDialogController;
        }
        if (params.durationDialogController !== undefined) {
            this.durationDialogController = params.durationDialogController;
        }
        if (params.intervalDialogController !== undefined) {
            this.intervalDialogController = params.intervalDialogController;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__settingInfo.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__settingInfo.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get settingInfo() {
        return this.__settingInfo.get();
    }
    set settingInfo(newValue) {
        this.__settingInfo.set(newValue);
    }
    showSettingDialog(sType) {
        switch (sType) {
            case AlarmSettingTypes.REPEAT:
                this.repeatDialogController.open();
                break;
            case AlarmSettingTypes.ALARM_NAME:
                this.reNameDialogController.open();
                break;
            case AlarmSettingTypes.RING_DURATION:
                this.durationDialogController.open();
                break;
            case AlarmSettingTypes.INTERVAL:
                this.intervalDialogController.open();
                break;
            default:
                break;
        }
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.margin({
                bottom: DimensionUtil.getVp({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }),
                left: DimensionUtil.getVp({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }),
                right: DimensionUtil.getVp({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
            });
            Column.borderRadius(DimensionUtil.getVp({ "id": 16777289, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Column.backgroundColor(Color.White);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            ForEach.create();
            const forEachItemGenFunction = (_item, index) => {
                const item = _item;
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Divider.create();
                    Divider.visibility(index === 0 ? Visibility.Hidden : Visibility.Visible);
                    Divider.opacity({ "id": 16777272, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    Divider.color({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    Divider.lineCap(LineCapStyle.Round);
                    Divider.margin({
                        left: DimensionUtil.getVp({ "id": 16777292, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }),
                        right: DimensionUtil.getVp({ "id": 16777292, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
                    });
                    if (!isInitialRender) {
                        Divider.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Row.create();
                    Row.height(DimensionUtil.getVp({ "id": 16777293, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                    Row.alignItems(VerticalAlign.Center);
                    Row.padding({
                        left: DimensionUtil.getVp({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }),
                        right: DimensionUtil.getVp({ "id": 16777297, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
                    });
                    Row.onClick(() => {
                        this.showSettingDialog(item.sType);
                    });
                    if (!isInitialRender) {
                        Row.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Text.create(item.title);
                    Text.fontSize(DimensionUtil.getFp({ "id": 16777298, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                    Text.fontWeight(FontWeight.Regular);
                    Text.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    Text.layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT);
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Text.create(item.content);
                    Text.fontSize(DimensionUtil.getFp({ "id": 16777291, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                    Text.fontWeight(FontWeight.Normal);
                    Text.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    Text.opacity({ "id": 16777290, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    if (!isInitialRender) {
                        Text.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Text.pop();
                this.observeComponentCreation((elmtId, isInitialRender) => {
                    ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                    Image.create({ "id": 16777312, "type": 20000, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                    Image.width(DimensionUtil.getVp({ "id": 16777296, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                    Image.height(DimensionUtil.getVp({ "id": 16777294, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
                    Image.objectFit(ImageFit.Fill);
                    Image.margin({
                        left: DimensionUtil.getVp({ "id": 16777295, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
                    });
                    if (!isInitialRender) {
                        Image.pop();
                    }
                    ViewStackProcessor.StopGetAccessRecording();
                });
                Row.pop();
            };
            this.forEachUpdateFunction(elmtId, this.settingInfo, forEachItemGenFunction, (item, index) => JSON.stringify(item) + index, true, true);
            if (!isInitialRender) {
                ForEach.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        ForEach.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=SettingItem.js.map