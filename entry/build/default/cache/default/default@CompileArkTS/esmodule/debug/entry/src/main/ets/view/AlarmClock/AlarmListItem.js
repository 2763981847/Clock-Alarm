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
import MainModel from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmClockViewModel';
import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import AlarmItem from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmItem';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
import promptAction from '@ohos:promptAction';
import { findNearestAlarmTime, generateNearestAlarmTimeToast } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/AlarmClockUtils';
export default class AlarmListItem extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.mainModel = MainModel.instant;
        this.alarmItem = new AlarmItem();
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.mainModel !== undefined) {
            this.mainModel = params.mainModel;
        }
        if (params.alarmItem !== undefined) {
            this.alarmItem = params.alarmItem;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            Row.padding({
                left: DimensionUtil.getVp({ "id": 16777242, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }),
                right: DimensionUtil.getVp({ "id": 16777242, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" })
            });
            Row.width(CommonConstants.FULL_LENGTH);
            Row.height(DimensionUtil.getVp({ "id": 16777247, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Row.backgroundColor(Color.White);
            Row.borderRadius(DimensionUtil.getVp({ "id": 16777249, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.width(CommonConstants.FULL_LENGTH);
            Column.alignItems(HorizontalAlign.Start);
            Column.layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Row.create();
            if (!isInitialRender) {
                Row.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.mainModel.getNoonContent(this.alarmItem.hour));
            __Text__CommonTextAttr(DimensionUtil.getFp({ "id": 16777248, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }), FontWeight.Regular);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.mainModel.getTaskTimeContent(this.alarmItem.hour, this.alarmItem.minute));
            __Text__CommonTextAttr(DimensionUtil.getFp({ "id": 16777250, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }), FontWeight.Regular, { left: DimensionUtil.getVp({ "id": 16777251, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }) });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Row.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create(this.mainModel.getDescContent(ObservedObject.GetRawObject(this.alarmItem)));
            __Text__CommonTextAttr(DimensionUtil.getFp({ "id": 16777244, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }), FontWeight.Normal, { top: DimensionUtil.getVp({ "id": 16777245, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }) }, { "id": 16777246, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Text.pop();
        Column.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Toggle.create({ type: ToggleType.Switch, isOn: this.alarmItem.isOpen });
            Toggle.onChange((isOn) => {
                this.mainModel.openAlarm(this.alarmItem.id, isOn);
                if (isOn) {
                    let nextAlarmTime = findNearestAlarmTime([this.alarmItem]);
                    promptAction.showToast({
                        message: generateNearestAlarmTimeToast(nextAlarmTime)
                    });
                }
            });
            Toggle.width(DimensionUtil.getVp({ "id": 16777253, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            Toggle.height(DimensionUtil.getVp({ "id": 16777252, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }));
            if (!isInitialRender) {
                Toggle.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Toggle.pop();
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
function __Text__CommonTextAttr(fontSize, fontWeight, margin, opacity) {
    Text.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
    Text.fontSize(fontSize);
    Text.fontWeight(fontWeight);
    Text.margin(margin != undefined ? margin : 0);
    Text.opacity(opacity != undefined ? opacity : 1);
}
//# sourceMappingURL=AlarmListItem.js.map