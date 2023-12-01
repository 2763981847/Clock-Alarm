import router from '@ohos.router';
import { CommonConstants } from '../../common/constant/CommonConstants';
import AlarmItem from '../../viewmodel/AlarmItem';
import AlarmListItem from './/AlarmListItem';
import DimensionUtil from '../../common/util/DimensionUtils';


@Component
export default struct AlarmList {
  @Link alarmItems: Array<AlarmItem>;
  private scroller: Scroller = new Scroller()

  build() {
    List({ scroller: this.scroller, space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
      ForEach(this.alarmItems, (item: AlarmItem) => {
        ListItem() {
          AlarmListItem({ alarmItem: item })
        }.onClick(() => {
          router.pushUrl({ url: 'pages/DetailIndex', params: { alarmItem: item } });
        }).transition({ type: TransitionType.All, scale: { x: 0, y: 0 } })
      }, (item: AlarmItem) =>item.id.toString())
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.alarm_list_content_distance'))
    })
    .listDirection(Axis.Vertical)
    .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    .margin({ top: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')) })
  }
}