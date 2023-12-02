import { CommonConstants } from '../common/constant/CommonConstants'
import AlarmClockPage from './AlarmClockPage'
import StopwatchPage from './StopwatchPage'
import TimerPage from './TimerPage'
import WorldClockPage from './WorldClockPage'
/**
 * 主页面
 */
@Entry
@Component
export default struct MainPage {
  // 定义状态变量 currentIndex，表示当前选中的 Tab 索引
  @State currentIndex: number = 0;

  // 定义字体颜色和选中时的字体颜色
  private fontColor: Resource = $r('app.color.grey_text');
  private selectedFontColor: Resource = $r('app.color.red_light');

  // 创建 TabsController 对象，用于管理 Tabs 组件
  private controller: TabsController = new TabsController();

  // 定义 TabBuilder 构建函数，用于创建 Tab 内容
  @Builder TabBuilder(index: number, name: string, image: Resource, activeImage: Resource) {
    Column({ space: 2 }) {
      // 根据当前索引选择显示普通图标或激活状态图标
      Image(this.currentIndex === index ? activeImage : image)
        .width(25)
        .height(25)
        .objectFit(ImageFit.Contain);
      // 根据当前索引设置字体颜色、字体大小和字体粗细
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize($r('app.float.font_size_SM'))
        .fontWeight(this.currentIndex === index ? 500 : 400);
    }
    .justifyContent(FlexAlign.End)
    .width(CommonConstants.FULL_LENGTH);
  }

  // 定义页面进入和退出的过渡效果
  pageTransition() {
    // 页面进入效果
    PageTransitionEnter({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .scale({ x: 0.8, y: 0.8 });
    // 页面退出效果
    PageTransitionExit({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .scale({ x: 0.8, y: 0.8 });
  }

  // 构建页面内容
  build() {
    // 创建 Tabs 组件
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      // 创建第一个 Tab 内容，即闹钟页面
      TabContent() {
        AlarmClockPage()
      }.tabBar(this.TabBuilder(0, '闹钟', $r('app.media.ic_alarm'), $r('app.media.ic_alarm_active')));

      // 创建第二个 Tab 内容，即世界时钟页面
      TabContent() {
        WorldClockPage()
      }.tabBar(this.TabBuilder(1, '世界时钟', $r('app.media.ic_world_clock'), $r('app.media.ic_world_clock_active')));

      // 创建第三个 Tab 内容，即秒表页面
      TabContent() {
        StopwatchPage()
      }.tabBar(this.TabBuilder(2, '秒表', $r('app.media.ic_stop_watch'), $r('app.media.ic_stop_watch_active')));

      // 创建第四个 Tab 内容，即计时器页面
      TabContent() {
        TimerPage()
      }.tabBar(this.TabBuilder(3, '计时器', $r('app.media.ic_timer'), $r('app.media.ic_timer_active')));
    }
    // 设置 Tabs 组件的样式和属性
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barHeight($r('app.float.bar_height'))
    .animationDuration(400)
    .onChange((index: number) => {
      // 监听 Tab 切换事件，更新 currentIndex 变量
      this.currentIndex = index;
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH);
  }
}
