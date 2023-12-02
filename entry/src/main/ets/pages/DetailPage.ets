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
import AlarmItem, { RepeatType } from '../viewmodel/AlarmItem';
import AlarmSettingItem from '../viewmodel/AlarmSettingItem';
import { AlarmSettingTypes } from '../common/constant/AlarmSettingTypes';
import { DetailConstants } from '../common/constant/DetailConstants';
import BackContainer from '../view/BackContainer';
import DetailModel from '../viewmodel/DetailViewModel';
import DatePickArea from '../view/detail/DatePickArea';
import SettingItem from '../view/Detail/SettingItem';
import DimensionUtil from '../common/util/DimensionUtils';
import prompt from '@ohos.prompt';
import promptAction from '@ohos.promptAction';
import { findNearestAlarmTime, generateNearestAlarmTimeToast, getNextAlarmTime } from '../common/util/AlarmClockUtils';

@Entry
@Component
struct DetailPage {
  @Watch('onAlarmItemChange') @Provide(DetailConstants.DEFAULT_PROVIDER_KEY) alarmItem: AlarmItem = new AlarmItem();
  @State repeatSettingArr: Array<AlarmSettingItem> = [];
  @State alarmSettingInfoArr: Array<AlarmSettingItem> = [];
  private isNew: boolean = true;
  private viewModel: DetailModel = DetailModel.instant;

  aboutToAppear() {
    let params = router.getParams() as Record<string, Object | undefined>;
    if (params !== undefined) {
      let alarmItem: AlarmItem = params.alarmItem as AlarmItem;
      if (alarmItem !== undefined) {
        this.isNew = false;
        this.alarmItem = alarmItem;
        this.viewModel.setAlarmDefaultTime(this.alarmItem);
      } else {
        this.viewModel.setAlarmDefaultTime();
      }
    } else {
      this.viewModel.setAlarmDefaultTime();
    }
    this.initData();
  }

  onAlarmItemChange() {
    this.initData();
  }

  initData() {
    this.repeatSettingArr = [
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_REPEAT,
        this.alarmItem.repeatType,
        AlarmSettingTypes.REPEAT)
    ];
    this.alarmSettingInfoArr = [
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_ALARM_NAME, this.alarmItem.name, AlarmSettingTypes.ALARM_NAME),
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_DURATION,
        this.alarmItem.duration + DetailConstants.DEFAULT_STRING_MINUTE, AlarmSettingTypes.RING_DURATION),
      new AlarmSettingItem(DetailConstants.DEFAULT_STRING_INTERVAL, this.alarmItem.intervalMinute
      + DetailConstants.DEFAULT_STRING_MINUTE + CommonConstants.DEFAULT_STRING_COMMA
      + this.alarmItem.intervalTimes + DetailConstants.DEFAULT_STRING_TIMES, AlarmSettingTypes.INTERVAL)
    ]
  }

  pageTransition() {
    // 定义页面进入时的效果，从底侧滑入，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom)
    // 定义页面退出时的效果，向底侧滑出，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .slide(SlideEffect.Bottom)
  }

  build() {
    Column() {
      BackContainer({
        header: this.isNew ? $r('app.string.new_alarm') : $r('app.string.update_alarm'),
        backImgRes: $r('app.media.ic_cancel'),
      }) {
        Button() {
          Image($r('app.media.ic_confirm')).objectFit(ImageFit.Fill)
        }
        .backgroundColor($r('app.color.trans_parent'))
        .width(DimensionUtil.getVp($r('app.float.title_button_size')))
        .height(DimensionUtil.getVp($r('app.float.title_button_size')))
        .onClick(() => {
          this.alarmItem.isOpen = true
          this.viewModel.setAlarmRemind(this.alarmItem);
          let nextAlarmTime = findNearestAlarmTime([this.alarmItem])
          promptAction.showToast({
            message: generateNearestAlarmTimeToast(nextAlarmTime)
          })
          router.back();
        })
      }

      DatePickArea()

      SettingItem({
        settingInfo: $repeatSettingArr
      })
      SettingItem({
        settingInfo: $alarmSettingInfoArr
      })

      Blank()

      Button($r('app.string.delete'))
        .visibility(this.isNew ? Visibility.None : Visibility.Visible)
        .width(DimensionUtil.getVp($r('app.float.delete_button_width')))
        .height(DimensionUtil.getVp($r('app.float.delete_button_height')))
        .fontSize(DimensionUtil.getFp($r('app.float.delete_button_font_size')))
        .fontColor($r('app.color.red_light'))
        .backgroundColor($r('app.color.grey_with_opacity'))
        .borderRadius(DimensionUtil.getVp($r('app.float.delete_button_radius')))
        .margin({
          bottom: DimensionUtil.getVp($r('app.float.delete_button_margin_bottom'))
        })
        .onClick(() => {
          this.viewModel.removeAlarmRemind(this.alarmItem.id);
          router.back();
        })
    }
    .backgroundColor($r('app.color.grey_light'))
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}