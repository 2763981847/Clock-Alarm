import display from '@ohos.display';
import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import PreferencesHandler from '../model/database/PreferencesHandler';
import { GlobalContext } from '../common/util/GlobalContext';

export default class EntryAbility extends UIAbility {
  /**
   * 创建实例时调用。
   */
  onCreate() {
    // 在全局上下文中设置对象实例
    GlobalContext.getContext().setObject('preference', PreferencesHandler.instance);
  }

  /**
   * 窗口阶段创建时调用。
   *
   * @param windowStage 创建的窗口阶段
   */
  async onWindowStageCreate(windowStage: window.WindowStage) {
    // AlarmClock 窗口已创建，为该能力设置主页面
    let globalDisplay: display.Display = display.getDefaultDisplaySync();
    // 在全局上下文中设置全局对象实例
    GlobalContext.getContext().setObject('globalDisplay', globalDisplay);
    let preference = GlobalContext.getContext().getObject('preference') as PreferencesHandler;
    // 配置偏好设置处理器
    await preference.configure(this.context.getApplicationContext());

    // 加载主页面的内容
    windowStage.loadContent('pages/MainPage', (err, data) => {
      if (err.code) {
        // 加载内容失败时记录错误日志
        hilog.error(0x0000, 'testTag', '加载内容失败。原因：%{public}s', JSON.stringify(err) ?? '');
        return;
      }
      // 加载内容成功时记录信息日志
      hilog.info(0x0000, 'testTag', '加载内容成功。数据：%{public}s', JSON.stringify(data) ?? '');
    });
  }
}
