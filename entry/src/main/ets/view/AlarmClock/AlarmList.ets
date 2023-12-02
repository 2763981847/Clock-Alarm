import router from '@ohos.router';
import { CommonConstants } from '../../common/constant/CommonConstants';
import AlarmItem from '../../viewmodel/AlarmItem';
import AlarmListItem from './/AlarmListItem';
import DimensionUtil from '../../common/util/DimensionUtils';

@Component
export default struct AlarmList {
  // 连接到闹钟项的状态变量
  @Link alarmItems: Array<AlarmItem>;

  // 用于滚动的 Scroller 组件
  private scroller: Scroller = new Scroller();

  // 构建页面内容
  build() {
    // 列表视图，包含闹钟项列表
    List({ scroller: this.scroller, space: DimensionUtil.getVp($r('app.float.alarm_list_space')) }) {
      ForEach(this.alarmItems, (item: AlarmItem) => {
        ListItem() {
          // 闹钟项列表项
          AlarmListItem({ alarmItem: item });
        }.onClick(() => {
          // 点击闹钟项后导航到详情页面，并传递闹钟项参数
          router.pushUrl({ url: 'pages/DetailPage', params: { alarmItem: item } });
        }).transition({ type: TransitionType.All, opacity: 0, scale: { x: 0, y: 0 } });
      }, (item: AlarmItem) => JSON.stringify(item)); // 使用闹钟项的 JSON 字符串表示作为标识符
    }
    .padding({
      left: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')),
      right: DimensionUtil.getVp($r('app.float.alarm_list_content_distance'))
    })
    .listDirection(Axis.Vertical)
    .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    .margin({ top: DimensionUtil.getVp($r('app.float.alarm_list_content_distance')) });
  }
}
