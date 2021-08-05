package com.reactnativeimpresajwplayer;

import android.graphics.Color;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.jwplayer.pub.api.license.LicenseUtil;
import java.util.Map;


public class ImpresaJwplayerViewManager extends SimpleViewManager<ImpresaJwplayerView> {
    public static final String REACT_CLASS = "ImpresaJwplayerView";
    public static final int COMMAND_PLAY = 1001;
    public static final int COMMAND_PAUSE = 1002;
    public static final int COMMAND_TOGGLE_FULL_SCREEN = 1003;
    public static final int COMMAND_DESTROY = 1004;

//  @Override
//  public void setViewState(@NonNull ImpresaJwplayerView view, @Nullable ReadableMap accessibilityState) {
//    super.setViewState(view, accessibilityState);
//  }

  @Override
    @NonNull
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    @NonNull
    public ImpresaJwplayerView createViewInstance(ThemedReactContext reactContext) {
      Log.d("Rodrigo", reactContext.getCurrentActivity().toString());
      ImpresaJwplayerView impresaJwplayerView = new ImpresaJwplayerView(reactContext, reactContext.getCurrentActivity());
      reactContext.addLifecycleEventListener(impresaJwplayerView);
      return impresaJwplayerView;
    }

    @ReactProp(name = "licenseKey")
    public void setLicenseKey(ImpresaJwplayerView view, String licenseKey) {
      LicenseUtil.setLicenseKey(view.getContext(), licenseKey);
    }

    @ReactProp(name = "title")
    public void setTitle(ImpresaJwplayerView view, String title) {
        view.setTitle(title);
    }

    @ReactProp(name = "description")
    public void setDescription(ImpresaJwplayerView view, String description) {
      view.setDesc(description);
    }

    @ReactProp(name = "mediaID")
    public void setMediaId(ImpresaJwplayerView view, String mediaID) {
      view.setMediaId(mediaID);
    }

     @ReactProp(name = "file")
      public void setFile(ImpresaJwplayerView view, String prop) {
      if (view.getFile()!=prop) {
        view.setFile(prop);
      }
    }

    @ReactProp(name = "imageFile")
    public void setImage(ImpresaJwplayerView view, String prop) {
      if (view.getImage()!=prop) {
        view.setImage(prop);
      }
    }

    @ReactProp(name = "adSchedule")
    public void setAdSchedule(ImpresaJwplayerView view, ReadableArray prop) {
      if(prop != null){
        view.setAdSchedule(prop);
      }
    }

    @ReactProp(name = "volume")
    public void setVolume(ImpresaJwplayerView view, String prop) {

    }

    @ReactProp(name = "autostart")
    public void setAutoStart(ImpresaJwplayerView view, Boolean prop) {
      view.setAutoStart(prop);
    }

  @Override
  public Map getExportedCustomBubblingEventTypeConstants() {
    return MapBuilder.builder()
      .put(
        "onFullScreen",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onFullScreen")))
      .put(
        "onFullScreenExit",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onFullScreenExit")))
      .put(
        "onPlay",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onPlay")))
      .put(
        "onPause",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onPause")))
      .build();
  }

  @Nullable
  @Override
  public Map<String, Integer> getCommandsMap() {
    Log.d("React"," View manager getCommandsMap:");
    return MapBuilder.of(
      "play",
      COMMAND_PLAY,
      "pause",
      COMMAND_PAUSE,
      "toggleFullScreen",
      COMMAND_TOGGLE_FULL_SCREEN,
      "destroy",
      COMMAND_DESTROY);
  }

  @Override
  public void receiveCommand(@NonNull ImpresaJwplayerView root, int commandId, @Nullable ReadableArray args) {
    super.receiveCommand(root, commandId, args);
    switch (commandId) {
      case COMMAND_PAUSE:
        Log.d("jwplayer"," View manager getCommandsMap:PAUSE");
        pause(root);
        break;
      case COMMAND_PLAY:
        Log.d("jwplayer"," View manager getCommandsMap:PLAY");
        play(root);
        break;
      case COMMAND_TOGGLE_FULL_SCREEN:
        Log.d("jwplayer"," View manager getCommandsMap:FULL");
        toggleFullScreen(root);
        break;
      case COMMAND_DESTROY:
        Log.d("jwplayer"," View manager getCommandsMap:DESTROY");
        destroy(root);
        break;
      default:
    }
  }

  public void play(ImpresaJwplayerView root) {
    if(root != null){
        root.getPlayer().play();
    }
  }

  public void pause(ImpresaJwplayerView root) {
    if(root != null){
      root.getPlayer().pause();
    }
  }

  public void toggleFullScreen(ImpresaJwplayerView root) {
    if(root != null){
      root.getPlayer().setFullscreen(!root.getPlayer().getFullscreen(), true);
    }
  }

  public void destroy(ImpresaJwplayerView root) {
    if(root != null){
      root.destroyPlayer();
    }
  }
}
