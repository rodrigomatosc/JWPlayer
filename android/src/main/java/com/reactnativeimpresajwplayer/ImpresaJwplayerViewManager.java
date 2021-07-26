package com.reactnativeimpresajwplayer;

import android.graphics.Color;
import android.util.Log;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.longtailvideo.jwplayer.JWPlayerView;

import java.util.Map;


public class ImpresaJwplayerViewManager extends SimpleViewManager<ImpresaJwplayerView> {
    public static final String REACT_CLASS = "ImpresaJwplayerView";
    public static final int COMMAND_PLAY = 1;
    public static final int COMMAND_PAUSE = 2;
    public static final int COMMAND_TOGGLE_FULL_SCREEN = 3;

    @Override
    @NonNull
    public String getName() {
        return REACT_CLASS;
    }

    @Override
    @NonNull
    public ImpresaJwplayerView createViewInstance(ThemedReactContext reactContext) {
      return new ImpresaJwplayerView(reactContext, reactContext.getCurrentActivity());
    }

    @ReactProp(name = "color")
    public void setColor(View view, String color) {
        view.setBackgroundColor(Color.parseColor(color));
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

    @ReactProp(name = "volume")
    public void setVolume(ImpresaJwplayerView view, String prop) {

    }

    @ReactProp(name = "autostart")
    public void setAutoStart(ImpresaJwplayerView view, Boolean prop) {
      view.setAutostart(prop);
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
      COMMAND_TOGGLE_FULL_SCREEN);
  }

  @Override
  public void receiveCommand(@NonNull ImpresaJwplayerView root, int commandId, @Nullable ReadableArray args) {
    super.receiveCommand(root, commandId, args);
    switch (commandId) {
      case COMMAND_PAUSE:
        Log.d("Rodrigo"," View manager getCommandsMap:PAUSE");
        pause(root);
        break;
      case COMMAND_PLAY:
        Log.d("Rodrigo"," View manager getCommandsMap:PLAY");
        play(root);
        break;
      case COMMAND_TOGGLE_FULL_SCREEN:
        Log.d("Rodrigo"," View manager getCommandsMap:FULL");
        toggleFullScreen(root);
        break;
      default:
    }
  }

  public void play(ImpresaJwplayerView root) {
    if(root != null){
        root.getmPlayerView().play();
    }
  }

  public void pause(ImpresaJwplayerView root) {
    if(root != null){
      root.getmPlayerView().pause();
    }
  }

  public void toggleFullScreen(ImpresaJwplayerView root) {
    if(root != null){
      root.getmPlayerView().setFullscreen(!root.getmPlayerView().getFullscreen(), true);
    }
  }
}
