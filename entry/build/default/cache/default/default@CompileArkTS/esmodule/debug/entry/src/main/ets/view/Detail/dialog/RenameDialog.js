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
export default class RenameDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__alarmItem = this.initializeConsume("alarmItem", "alarmItem");
        this.name = '';
        this.controller = new CustomDialogController({
            builder: () => {
                let jsDialog = new RenameDialog(this, {});
                jsDialog.setController(this.controller);
                ViewPU.create(jsDialog);
            },
            autoCancel: true
        }, this);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.name !== undefined) {
            this.name = params.name;
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
                        title: { "id": 16777220, "type": 10003, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" },
                        controller: this.controller,
                        onConfirm: () => {
                            this.alarmItem.name = this.name;
                        },
                        closer: () => {
                            this.observeComponentCreation((elmtId, isInitialRender) => {
                                ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                                TextArea.create({ text: this.alarmItem.name });
                                TextArea.width(CommonConstants.FULL_LENGTH);
                                TextArea.margin({ bottom: DimensionUtil.getVp({ "id": 16777286, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" }) });
                                TextArea.onChange((value) => {
                                    this.name = value;
                                });
                                if (!isInitialRender) {
                                    TextArea.pop();
                                }
                                ViewStackProcessor.StopGetAccessRecording();
                            });
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
//# sourceMappingURL=RenameDialog.js.map