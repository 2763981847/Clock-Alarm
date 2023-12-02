import { CommonConstants } from '../common/constant/CommonConstants'
import AlarmClockPage from './AlarmClockPage'
import StopwatchPage from './StopwatchPage'
import TimerPage from './TimerPage'
import WorldClockPage from './WorldClockPage'

@Entry
@Component
struct MainPage {
  // 定义状态变量
  @State currentIndex: number = 0
  private fontColor: Resource = $r('app.color.grey_text')
  private selectedFontColor: Resource = $r('app.color.red_light')
  // 创建 TabsController 对象
  private controller: TabsController = new TabsController()
  // 定义 TabBuilder 构建函数
  @Builder TabBuilder(index: number, name: string, image: Resource, activeImage: Resource) {
    Column({ space: 2 }) {
      // 根据当前索引选择显示普通图标或激活状态图标
      Image(this.currentIndex === index ? activeImage : image)
        .width(25)
        .height(25)
        .objectFit(ImageFit.Contain)
      // 根据当前索引设置字体颜色、字体大小和字体粗细
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize($r('app.float.font_size_SM'))
        .fontWeight(this.currentIndex === index ? 500 : 400)
    }
    .justifyContent(FlexAlign.End)
    .width(CommonConstants.FULL_LENGTH)
  }

  pageTransition() {
    // 定义页面进入时的效果，从底侧滑入，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .scale({ x: 0.8, y: 0.8 })
    // 定义页面退出时的效果，向顶侧滑出，时长为300ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionExit({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION })
      .scale({ x: 0.8, y: 0.8 })
  }

  build() {
    // 创建 Tabs 组件
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      // 创建第一个 Tab 内容，即闹钟页面
      TabContent() {
        AlarmClockPage()
      }.tabBar(this.TabBuilder(0, '闹钟', $r('app.media.ic_alarm'), $r('app.media.ic_alarm_active')))

      // 创建第二个 Tab 内容，即世界时钟页面
      TabContent() {
        WorldClockPage()
      }.tabBar(this.TabBuilder(1, '世界时钟', $r('app.media.ic_world_clock'), $r('app.media.ic_world_clock_active')))

      // 创建第三个 Tab 内容，即秒表页面
      TabContent() {
        StopwatchPage()
      }.tabBar(this.TabBuilder(2, '秒表', $r('app.media.ic_stop_watch'), $r('app.media.ic_stop_watch_active')))

      // 创建第四个 Tab 内容，即计时器页面
      TabContent() {
        TimerPage()
      }.tabBar(this.TabBuilder(3, '计时器', $r('app.media.ic_timer'), $r('app.media.ic_timer_active')))
    }
    // 设置 Tabs 组件的样式和属性
    .vertical(false)
    .barMode(BarMode.Fixed)
    .barHeight($r('app.float.bar_height'))
    .animationDuration(400)
    .onChange((index: number) => {
      this.currentIndex = index
    })
    .width(CommonConstants.FULL_LENGTH)
    .height(CommonConstants.FULL_LENGTH)
  }
}