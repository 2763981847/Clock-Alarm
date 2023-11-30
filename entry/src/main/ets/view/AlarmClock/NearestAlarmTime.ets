import { CommonConstants } from '../../common/constant/CommonConstants'
import AlarmClockViewModel from '../../viewmodel/AlarmClockViewModel'

@Preview
@Component
export default struct NearestAlarmTime {
  @Link nearestAlarmTime: {
    days: number,
    hours: number,
    minutes: number
  }

  build() {
    Text() {
      if (this.nearestAlarmTime) {
        Span("闹钟将在 ").fontSize($r('app.float.font_size_S')).fontColor($r('app.color.grey_text'))
        Span(AlarmClockViewModel.fillZero(this.nearestAlarmTime?.days))
          .fontColor($r('app.color.grey_divider'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.font_size_L'))
          .decoration({ type: TextDecorationType.Underline, color: Color.Red })
        Span(" 天 ").fontSize($r('app.float.font_size_S')).fontColor($r('app.color.grey_text'))
        Span(AlarmClockViewModel.fillZero(this.nearestAlarmTime?.hours))
          .fontColor($r('app.color.grey_divider'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.font_size_L'))
          .decoration({ type: TextDecorationType.Underline, color: Color.Red })
        Span(" 小时 ").fontSize($r('app.float.font_size_S')).fontColor($r('app.color.grey_text'))
        Span(AlarmClockViewModel.fillZero(this.nearestAlarmTime?.minutes))
          .fontColor($r('app.color.grey_divider'))
          .fontWeight(FontWeight.Medium)
          .fontSize($r('app.float.font_size_L'))
          .decoration({ type: TextDecorationType.Underline, color: Color.Red })
        Span(" 分钟后响起").fontSize($r('app.float.font_size_S')).fontColor($r('app.color.grey_text'))

      } else {
        Span("已关闭所有闹钟")
          .fontSize($r('app.float.font_size_MP'))
          .opacity($r('app.float.alarms_item_desc_text_opacity'))
          .fontColor($r('app.color.grey_text'))
      }
    }.width(CommonConstants.FULL_LENGTH).textAlign(TextAlign.Center)
  }
}
