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
import display from '@ohos:display';
import UIAbility from '@ohos:app.ability.UIAbility';
import hilog from '@ohos:hilog';
import PreferencesHandler from '@bundle:com.huawei.alarmclock/entry/ets/model/database/PreferencesHandler';
import { GlobalContext } from '@bundle:com.huawei.alarmclock/entry/ets/common/util/GlobalContext';
export default class EntryAbility extends UIAbility {
    onCreate() {
        GlobalContext.getContext().setObject('preference', PreferencesHandler.instance);
    }
    async onWindowStageCreate(windowStage) {
        // AlarmClock window is created, set main page for this ability
        let globalDisplay = display.getDefaultDisplaySync();
        GlobalContext.getContext().setObject('globalDisplay', globalDisplay);
        let preference = GlobalContext.getContext().getObject('preference');
        await preference.configure(this.context.getApplicationContext());
        windowStage.loadContent('pages/MainPage', (err, data) => {
            var _a, _b;
            if (err.code) {
                hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', (_a = JSON.stringify(err)) !== null && _a !== void 0 ? _a : '');
                return;
            }
            hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', (_b = JSON.stringify(data)) !== null && _b !== void 0 ? _b : '');
        });
    }
}
//# sourceMappingURL=EntryAbility.js.map