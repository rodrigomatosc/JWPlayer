import React from 'react';
import { ViewStyle } from 'react-native';
declare type ImpresaJwplayerProps = {
    licenseKey?: string;
    file?: string;
    style?: ViewStyle;
    imageFile?: string;
    volume?: number;
    autostart?: boolean;
    repeatVideo?: boolean;
    controls?: boolean;
    onFullScreen?: Function;
    onFullScreenExit?: Function;
    onPlay?: Function;
    onPause?: Function;
    ref?: any;
    adSchedule?: Array<{
        tag: String;
        offset: string;
    }>;
    mediaId?: string;
    title?: string;
    desc?: string;
    playPauseWhenVisible?: boolean;
};
export declare const ImpresaJwplayerComponent: import("react-native").HostComponent<ImpresaJwplayerProps>;
declare const _default: React.MemoExoticComponent<React.ForwardRefExoticComponent<Pick<ImpresaJwplayerProps, "style" | "licenseKey" | "file" | "imageFile" | "volume" | "autostart" | "repeatVideo" | "controls" | "onFullScreen" | "onFullScreenExit" | "onPlay" | "onPause" | "adSchedule" | "mediaId" | "title" | "desc" | "playPauseWhenVisible"> & React.RefAttributes<unknown>>>;
export default _default;
