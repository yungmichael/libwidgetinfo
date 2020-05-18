import { XenHTMLMiddleware, DataProviderUpdateNamespace } from '../types';
import NativeInterface from '../native-interface';

import XenInfoWeather from './weather-compat';
import XenInfoBattery from './battery-compat';
import XenInfoSystem from './system-compat';
import XenInfoMedia from './media-compat';

/**
 * @ignore
 */
export default class XenInfoMiddleware implements XenHTMLMiddleware {
    private providers: Map<DataProviderUpdateNamespace, any>;

    private weatherCompat: XenInfoWeather = null;
    private batteryCompat: XenInfoBattery = null;
    private systemCompat: XenInfoSystem = null;
    private mediaCompat: XenInfoMedia = null;

    public initialise(parent: NativeInterface, providers: Map<DataProviderUpdateNamespace, any>): void {
        if (!this.requiresXenInfoCompat()) return;

        this.providers = providers;

        // Setup compatibility things
        this.weatherCompat = new XenInfoWeather(this.providers, this.notifyXenInfoDataChanged);
        this.batteryCompat = new XenInfoBattery(this.providers, this.notifyXenInfoDataChanged);
        this.systemCompat = new XenInfoSystem(this.providers, this.notifyXenInfoDataChanged);
        this.mediaCompat = new XenInfoMedia(this.providers, this.notifyXenInfoDataChanged);

        // Fire off first updates - ensures that if a widget uses data from another provider
        // in the specified namespace, everything just *works*
        this.weatherCompat.onFirstUpdate();
        this.batteryCompat.onFirstUpdate();
        this.systemCompat.onFirstUpdate();
        this.mediaCompat.onFirstUpdate();
    }

    private requiresXenInfoCompat(): boolean {
        return (window as any).mainUpdate !== undefined;
    }

    private notifyXenInfoDataChanged(namespace: string) {
        // Call mainUpdate with changed namespace
        if ((window as any).mainUpdate !== undefined) {
            (window as any).mainUpdate(namespace);
        }
    }

    invokeAction(action: any): void {}
}