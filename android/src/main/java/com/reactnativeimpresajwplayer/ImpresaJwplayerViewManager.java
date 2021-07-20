package com.reactnativeimpresajwplayer;

import android.graphics.Color;
import android.view.View;

import androidx.annotation.NonNull;

import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.longtailvideo.jwplayer.JWPlayerView;

import java.util.Map;

public class ImpresaJwplayerViewManager extends SimpleViewManager<ImpresaJwplayerView> {
    public static final String REACT_CLASS = "ImpresaJwplayerView";

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

}
