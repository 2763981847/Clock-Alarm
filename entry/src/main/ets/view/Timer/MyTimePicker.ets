import { CommonConstants } from '../../common/constant/CommonConstants'
import DimensionUtil from '../../common/util/DimensionUtils'

@Component
export default struct MyTimePicker {
  @Link count: number
  private hour: number = Math
    .floor(this.count / CommonConstants.MILLISECONDS_PER_HOUR)
  private minute: number = Math
    .floor((this.count - this.hour * CommonConstants.MILLISECONDS_PER_HOUR) / CommonConstants.MILLISECONDS_PER_MINUTE)
  private second: number = Math
    .floor((this.count - this.hour * CommonConstants.MILLISECONDS_PER_HOUR - this.minute * CommonConstants.MILLISECONDS_PER_MINUTE) / CommonConstants.MILLISECONDS_PER_SECOND)

  refreshCount() {
    this.count = this.second * CommonConstants.MILLISECONDS_PER_SECOND +
    this.minute * CommonConstants.MILLISECONDS_PER_MINUTE +
    this.hour * CommonConstants.MILLISECONDS_PER_HOUR
  }

  generateRangeArray(start: number, end: number): Array<string> {
    return Array.from({ length: end - start + 1 }, (_, i) => (start + i).toString().padStart(2, '0'));
  }

  build() {
    Row() {
      TextPicker({ range: this.generateRangeArray(0, 23), selected: this.hour })
        .onChange((value: string) => {
          this.hour = Number.parseInt(value);
          this.refreshCount();
        })
        .width($r('app.float.stop_watch_font_size'))
      Text("时")
        .fontSize($r('app.float.font_size_M'))
      TextPicker({ range: this.generateRangeArray(0, 59), selected: this.minute })
        .onChange((value: string) => {
          this.minute = Number.parseInt(value);
          this.refreshCount();
        })
        .width($r('app.float.stop_watch_font_size'))
      Text("分")
        .fontSize($r('app.float.font_size_M'))
      TextPicker({ range: this.generateRangeArray(0, 59), selected: this.second })
        .onChange((value: string) => {
          this.second = Number.parseInt(value);
          this.refreshCount();
        })
        .width($r('app.float.stop_watch_font_size'))

      Text("秒")
        .fontSize($r('app.float.font_size_M'))
    }.width(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.SpaceAround)
    .padding({
      left: DimensionUtil.getVp($r('app.float.title_horizon_margin')),
      right: DimensionUtil.getVp($r('app.float.title_horizon_margin'))
    })
  }
}