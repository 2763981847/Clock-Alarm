import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import AlarmClockViewModel from '@bundle:com.huawei.alarmclock/entry/ets/viewmodel/AlarmClockViewModel';
export default class NearestAlarmTime extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__nearestAlarmTime = new SynchedPropertyObjectTwoWayPU(params.nearestAlarmTime, this, "nearestAlarmTime");
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__nearestAlarmTime.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__nearestAlarmTime.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get nearestAlarmTime() {
        return this.__nearestAlarmTime.get();
    }
    set nearestAlarmTime(newValue) {
        this.__nearestAlarmTime.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Text.create();
            Text.width(CommonConstants.FULL_LENGTH);
            Text.textAlign(TextAlign.Center);
            if (!isInitialRender) {
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            If.create();
            if (this.nearestAlarmTime) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create("闹钟将在 ");
                        Span.fontSize({ "id": 16777278, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontColor({ "id": 16777237, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        var _a;
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(AlarmClockViewModel.fillZero((_a = this.nearestAlarmTime) === null || _a === void 0 ? void 0 : _a.days));
                        Span.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontWeight(FontWeight.Medium);
                        Span.fontSize({ "id": 16777275, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.decoration({ type: TextDecorationType.Underline, color: Color.Red });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(" 天 ");
                        Span.fontSize({ "id": 16777278, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontColor({ "id": 16777237, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        var _a;
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(AlarmClockViewModel.fillZero((_a = this.nearestAlarmTime) === null || _a === void 0 ? void 0 : _a.hours));
                        Span.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontWeight(FontWeight.Medium);
                        Span.fontSize({ "id": 16777275, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.decoration({ type: TextDecorationType.Underline, color: Color.Red });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(" 小时 ");
                        Span.fontSize({ "id": 16777278, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontColor({ "id": 16777237, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        var _a;
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(AlarmClockViewModel.fillZero((_a = this.nearestAlarmTime) === null || _a === void 0 ? void 0 : _a.minutes));
                        Span.fontColor({ "id": 16777235, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontWeight(FontWeight.Medium);
                        Span.fontSize({ "id": 16777275, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.decoration({ type: TextDecorationType.Underline, color: Color.Red });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create(" 分钟后响起");
                        Span.fontSize({ "id": 16777278, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontColor({ "id": 16777237, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        Span.create("已关闭所有闹钟");
                        Span.fontSize({ "id": 16777277, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.opacity({ "id": 16777246, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        Span.fontColor({ "id": 16777237, "type": 10001, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
                        if (!isInitialRender) {
                            Span.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                });
            }
            if (!isInitialRender) {
                If.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        If.pop();
        Text.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=NearestAlarmTime.js.map