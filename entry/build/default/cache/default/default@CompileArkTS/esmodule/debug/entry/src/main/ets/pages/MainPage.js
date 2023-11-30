import { CommonConstants } from '@bundle:com.huawei.alarmclock/entry/ets/common/constant/CommonConstants';
import AlarmClockPage from '@bundle:com.huawei.alarmclock/entry/ets/pages/AlarmClockPage';
import StopwatchPage from '@bundle:com.huawei.alarmclock/entry/ets/pages/StopwatchPage';
import TimerPage from '@bundle:com.huawei.alarmclock/entry/ets/pages/timerPage';
import WorldClockPage from '@bundle:com.huawei.alarmclock/entry/ets/pages/WorldClockPage';
class MainPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1) {
        super(parent, __localStorage, elmtId);
        this.__currentIndex = new ObservedPropertySimplePU(0, this, "currentIndex");
        this.fontColor = '#182431';
        this.selectedFontColor = '#007DFF';
        this.controller = new TabsController();
        this.setInitiallyProvidedValue(params);
    }
    setInitiallyProvidedValue(params) {
        if (params.currentIndex !== undefined) {
            this.currentIndex = params.currentIndex;
        }
        if (params.fontColor !== undefined) {
            this.fontColor = params.fontColor;
        }
        if (params.selectedFontColor !== undefined) {
            this.selectedFontColor = params.selectedFontColor;
        }
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__currentIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__currentIndex.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    get currentIndex() {
        return this.__currentIndex.get();
    }
    set currentIndex(newValue) {
        this.__currentIndex.set(newValue);
    }
    // 定义 TabBuilder 构建函数
    TabBuilder(index, name, image, activeImage, parent = null) {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            Column.create();
            Column.justifyContent(FlexAlign.End);
            Column.width(CommonConstants.FULL_LENGTH);
            if (!isInitialRender) {
                Column.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 根据当前索引选择显示普通图标或激活状态图标
            Image.create(this.currentIndex === index ? activeImage : image);
            // 根据当前索引选择显示普通图标或激活状态图标
            Image.width(24);
            // 根据当前索引选择显示普通图标或激活状态图标
            Image.height(24);
            if (!isInitialRender) {
                // 根据当前索引选择显示普通图标或激活状态图标
                Image.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 根据当前索引设置字体颜色、字体大小和字体粗细
            Text.create(name);
            // 根据当前索引设置字体颜色、字体大小和字体粗细
            Text.fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor);
            // 根据当前索引设置字体颜色、字体大小和字体粗细
            Text.fontSize({ "id": 16777278, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            // 根据当前索引设置字体颜色、字体大小和字体粗细
            Text.fontWeight(this.currentIndex === index ? 500 : 400);
            if (!isInitialRender) {
                // 根据当前索引设置字体颜色、字体大小和字体粗细
                Text.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        // 根据当前索引设置字体颜色、字体大小和字体粗细
        Text.pop();
        Column.pop();
    }
    pageTransition() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            PageTransition.create();
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 定义页面进入时的效果，从底侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionEnter.create({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION });
            // 定义页面进入时的效果，从底侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionEnter.scale({ x: 0.8, y: 0.8 });
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 定义页面退出时的效果，向顶侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionExit.create({ type: RouteType.None, duration: CommonConstants.ANIMATION_SHORT_DURATION });
            // 定义页面退出时的效果，向顶侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
            PageTransitionExit.scale({ x: 0.8, y: 0.8 });
            ViewStackProcessor.StopGetAccessRecording();
        });
        PageTransition.pop();
    }
    initialRender() {
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            // 创建 Tabs 组件
            Tabs.create({ barPosition: BarPosition.End, controller: this.controller });
            // 创建 Tabs 组件
            Tabs.vertical(false);
            // 创建 Tabs 组件
            Tabs.barMode(BarMode.Fixed);
            // 创建 Tabs 组件
            Tabs.barHeight({ "id": 16777254, "type": 10002, params: [], "bundleName": "com.huawei.alarmclock", "moduleName": "entry" });
            // 创建 Tabs 组件
            Tabs.animationDuration(400);
            // 创建 Tabs 组件
            Tabs.onChange((index) => {
                this.currentIndex = index;
            });
            // 创建 Tabs 组件
            Tabs.width(CommonConstants.FULL_LENGTH);
            // 创建 Tabs 组件
            Tabs.height(CommonConstants.FULL_LENGTH);
            if (!isInitialRender) {
                // 创建 Tabs 组件
                Tabs.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new AlarmClockPage(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, 0, '闹钟', null, null);
                } });
            if (!isInitialRender) {
                // 创建第一个 Tab 内容，即闹钟页面
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new WorldClockPage(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, 1, '世界时钟', null, null);
                } });
            if (!isInitialRender) {
                // 创建第二个 Tab 内容，即世界时钟页面
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new StopwatchPage(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, 2, '秒表', null, null);
                } });
            if (!isInitialRender) {
                // 创建第三个 Tab 内容，即秒表页面
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        this.observeComponentCreation((elmtId, isInitialRender) => {
            ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
            TabContent.create(() => {
                {
                    this.observeComponentCreation((elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        if (isInitialRender) {
                            ViewPU.create(new TimerPage(this, {}, undefined, elmtId));
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, 3, '计时器', null, null);
                } });
            if (!isInitialRender) {
                // 创建第四个 Tab 内容，即计时器页面
                TabContent.pop();
            }
            ViewStackProcessor.StopGetAccessRecording();
        });
        TabContent.pop();
        // 创建 Tabs 组件
        Tabs.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
ViewStackProcessor.StartGetAccessRecordingFor(ViewStackProcessor.AllocateNewElmetIdForNextComponent());
loadDocument(new MainPage(undefined, {}));
ViewStackProcessor.StopGetAccessRecording();
//# sourceMappingURL=MainPage.js.map