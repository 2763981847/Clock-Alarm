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
import { AlarmClockConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/AlarmClockConstants';
import DimensionUtil from '@bundle:com.huawei.alarmclock/entry/ets/common/util/DimensionUtils';
export default class ClockArea extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.drawInterval = CommonConstants.DEFAULT_NUMBER_NEGATIVE;
        this.canvasSize = DimensionUtil.getVp({ "id": 16777255, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
        this.clockRadius = this.canvasSize / CommonConstants.DEFAULT_DOUBLE - CommonConstants.DEFAULT_DOUBLE;
        this.settings = new RenderingContextSettings(true);
        this.renderContext = new CanvasRenderingContext2D(this.settings);
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.drawInterval !== undefined) {
            this.drawInterval = params.drawInterval;
        }
        if (params.canvasSize !== undefined) {
            this.canvasSize = params.canvasSize;
        }
        if (params.clockRadius !== undefined) {
            this.clockRadius = params.clockRadius;
        }
        if (params.settings !== undefined) {
            this.settings = params.settings;
        }
        if (params.renderContext !== undefined) {
            this.renderContext = params.renderContext;
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
    aboutToDisappear() {
        clearInterval(this.drawInterval);
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Canvas.create(this.renderContext);
            Canvas.width(this.canvasSize);
            Canvas.aspectRatio(CommonConstants.DEFAULT_LAYOUT_WEIGHT);
            Canvas.onReady(() => {
                if (this.drawInterval === CommonConstants.DEFAULT_NUMBER_NEGATIVE) {
                    this.startDrawTask();
                }
            });
            if (!isInitialRender) {
                Canvas.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        Canvas.pop();
    }
    // 启动绘画任务
    startDrawTask() {
        this.renderContext.translate(this.canvasSize / CommonConstants.DEFAULT_DOUBLE, this.canvasSize / CommonConstants.DEFAULT_DOUBLE);
        this.drawClockArea();
        this.drawInterval = setInterval(() => {
            this.drawClockArea();
        }, AlarmClockConstants.DEFAULT_ONE_SECOND_MS);
    }
    // 开始绘制时钟区域
    drawClockArea() {
        this.renderContext.clearRect(-this.canvasSize, -this.canvasSize / CommonConstants.DEFAULT_DOUBLE, this.canvasSize * CommonConstants.DEFAULT_DOUBLE, this.canvasSize);
        let date = new Date();
        let hours = date.getHours();
        let minutes = date.getMinutes();
        let seconds = date.getSeconds();
        this.drawPan();
        this.drawPointer(CommonConstants.DEFAULT_INTERVAL_MINUTE_MAX * (hours > CommonConstants.DEFAULT_TOTAL_HOUR
            ? hours - CommonConstants.DEFAULT_TOTAL_HOUR
            : hours)
            + minutes / CommonConstants.DEFAULT_TOTAL_HOUR * CommonConstants.DEFAULT_COMMON_DEGREE, AlarmClockConstants.HOUR_POINTER_IMAGE_URL);
        this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * minutes, AlarmClockConstants.MINUTE_POINTER_IMAGE_URL);
        this.drawPointer(CommonConstants.DEFAULT_COMMON_DEGREE * seconds, AlarmClockConstants.SECOND_POINTER_IMAGE_URL);
    }
    // 绘制表盘
    drawPan() {
        this.renderContext.beginPath();
        let secondImg = new ImageBitmap(AlarmClockConstants.CLOCK_PAN_IMAGE_URL);
        let imgWidth = this.clockRadius * 2;
        this.renderContext.drawImage(secondImg, -this.clockRadius, -this.clockRadius, imgWidth, imgWidth);
        this.renderContext.restore();
    }
    // 绘制时针、分针、秒针
    drawPointer(degree, pointerImgRes) {
        this.renderContext.save();
        let theta = (degree + AlarmClockConstants.DEFAULT_HORIZONTAL_ANGLE) * Math.PI / AlarmClockConstants.DEFAULT_HORIZONTAL_ANGLE;
        this.renderContext.rotate(theta);
        this.renderContext.beginPath();
        let secondImg = new ImageBitmap(pointerImgRes);
        let imgWidth = CommonConstants.DEFAULT_POINTER_WIDTH;
        this.renderContext.drawImage(secondImg, -imgWidth / CommonConstants.DEFAULT_DOUBLE, -this.clockRadius, imgWidth, this.clockRadius * CommonConstants.DEFAULT_DOUBLE);
        this.renderContext.restore();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
//# sourceMappingURL=ClockArea.js.map