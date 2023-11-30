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

import router from '@ohos.router';
import { CommonConstants } from '../common/constant/CommonConstants';
import AlarmItem from '../viewmodel/AlarmItem';
import { AlarmClockConstants } from '../common/constant/AlarmClockConstants';
import AlarmClockViewModel from '../viewmodel/AlarmClockViewModel';
import ClockArea from '../view/WorldClock/ClockArea';
import AlarmList from '../view/AlarmClock/AlarmList';
import DimensionUtil from '../common/util/DimensionUtils';
import HeaderContainer from '../view/HeaderContainer';
import { findNearestAlarmTime } from '../common/util/AlarmClockUtils';
import NearestAlarmTime from '../view/AlarmClock/NearestAlarmTime';


@Component
export default struct AlarmClockPage {
  private intervalId: number = CommonConstants.DEFAULT_NUMBER_NEGATIVE;
  private alarmClockModel: AlarmClockViewModel = AlarmClockViewModel.instant;
  @State alarmItems: Array<AlarmItem> = new Array();
  @State isAuth: boolean = false;
  @State nearestAlarmTime: {
    days: number,
    hours: number,
    minutes: number
  } = null

  aboutToAppear() {
    this.alarmClockModel.queryAlarmsTasker((alarms: Array<AlarmItem>) => {
      animateTo({ duration: CommonConstants.ANIMATION_MEDIUM_DURATION }, () => {
        this.alarmItems = alarms;
        this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems)
      })
    })
    this.intervalId = setInterval(() => {
      this.nearestAlarmTime = findNearestAlarmTime(this.alarmItems)
      this.alarmClockModel.disableExpiredReminders()
    }, AlarmClockConstants.DEFAULT_ONE_SECOND_MS);
  }

  aboutToDisappear() {
    clearInterval(this.intervalId);
  }

  build() {

    Column() {
      HeaderContainer({ title: AlarmClockConstants.DEFAULT_STRING_ALARM }) {
        Row({ space: DimensionUtil.getVp($r('app.float.new_alarm_button_size')) }) {
          Button() {
            Image($r('app.media.ic_add')).objectFit(ImageFit.Fill)
          }
          .stateEffect(false)
          .backgroundColor($r('app.color.trans_parent'))
          .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
          .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
          .onClick(() => {
            router.pushUrl({ url: 'pages/DetailIndex' });
          })

          Button() {
            Image($r('app.media.ic_edit')).objectFit(ImageFit.Fill)
          }
          .stateEffect(false)
          .backgroundColor($r('app.color.trans_parent'))
          .width(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
          .height(DimensionUtil.getVp($r('app.float.new_alarm_button_size')))
          .onClick(() => {
            // todo
          })
        }
      }

      NearestAlarmTime({ nearestAlarmTime: $nearestAlarmTime })


      AlarmList({ alarmItems: $alarmItems })
    }
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
    .backgroundColor($r('app.color.grey_light'))
  }
}