package com.reactnativeimpresajwplayer;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.appcompat.app.ActionBar;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.longtailvideo.jwplayer.JWPlayerView;
import com.longtailvideo.jwplayer.events.FullscreenEvent;
import com.longtailvideo.jwplayer.events.PauseEvent;
import com.longtailvideo.jwplayer.events.PlayEvent;
import com.longtailvideo.jwplayer.events.listeners.VideoPlayerEvents;
import com.longtailvideo.jwplayer.media.playlists.PlaylistItem;

public class ImpresaJwplayerView extends FrameLayout implements
  VideoPlayerEvents.OnFullscreenListener,
  VideoPlayerEvents.OnPlayListener,
  VideoPlayerEvents.OnPauseListener {

  //Props
  private String file = "";
  private String image = "";
  private String title = "";
  private String desc = "";
  private String mediaId = "";
  private Double volume = 100D;
  private String customStyle;
  private String adVmap = "";
  private Boolean autostart = true;

  private ReactContext reactContext;
  private JWPlayerView mPlayerView;
  private PlaylistItem newPlayListItem;

  public ImpresaJwplayerView(Context context) {
    super(context);
    reactContext = (ReactContext) context;
  }

  public ImpresaJwplayerView(Context context, Activity activity) {
    super(context);
    reactContext = (ReactContext) context;

    FrameLayout jwPlayerLayout = (FrameLayout) activity.getLayoutInflater().inflate(R.layout.jwplayer_view, null);
    this.addView(jwPlayerLayout);

    mPlayerView = findViewById(R.id.jwplayer);
    mPlayerView.getConfig().setAutostart(autostart);

    // Handle hiding/showing of ActionBar
    mPlayerView.addOnFullscreenListener(this);
    mPlayerView.addOnPlayListener(this);
    mPlayerView.addOnPauseListener(this);

    configurePlayList();
  }

  private void configurePlayList(){
    newPlayListItem = new PlaylistItem.Builder().build();
    if(newPlayListItem != null){
      mPlayerView.load(newPlayListItem);
    }
  }

  public String getFile() {
    return file;
  }

  public String getImage() {
    return image;
  }

  public String getTitle() {
    return title;
  }

  public String getDesc() {
    return desc;
  }

  public String getMediaId() {
    return mediaId;
  }

  public Double getVolume() {
    return volume;
  }

  public void setVolume(Double volume) {
    this.volume = volume;
  }

  public Boolean getAutostart() {
    return autostart;
  }

  public JWPlayerView getmPlayerView() {
    return mPlayerView;
  }

  public void setAutostart(Boolean autostart) {
    this.autostart = autostart;
    mPlayerView.getConfig().setAutostart(autostart);
    mPlayerView.load(newPlayListItem);
  }

  public void setFile(String file) {
    this.file = file;
    newPlayListItem.setFile(file);
    mPlayerView.load(newPlayListItem);
  }

  public void setImage(String image) {
    this.image = image;
    newPlayListItem.setImage(image);
    mPlayerView.load(newPlayListItem);
  }

  public void setTitle(String title) {
    this.title = title;
    newPlayListItem.setTitle(title);
    mPlayerView.load(newPlayListItem);
  }

  public void setDesc(String desc) {
    this.desc = desc;
    newPlayListItem.setDescription(desc);
    mPlayerView.load(newPlayListItem);
  }

  public void setMediaId(String mediaId) {
    this.mediaId = mediaId;
  }

  public void setCustomStyle(String customStyle) {
    this.customStyle = customStyle;
  }

  public void setAdVmap(String adVmap) {
    this.adVmap = adVmap;
  }

  @Override
  public void requestLayout() {
    super.requestLayout();
    post(measureAndLayout);
  }

  private final Runnable measureAndLayout = new Runnable() {
    @Override
    public void run() {
      measure(
        MeasureSpec.makeMeasureSpec(getWidth(), MeasureSpec.EXACTLY),
        MeasureSpec.makeMeasureSpec(getHeight(), MeasureSpec.EXACTLY));
      layout(getLeft(), getTop(), getRight(), getBottom());
    }
  };

  @Override
  public void onFullscreen(FullscreenEvent fullscreenEvent) {
    String keyEvent = "";
    if (fullscreenEvent.getFullscreen()) {
      keyEvent = "onFullScreen";
    } else {
      keyEvent = "onFullScreenExit";
    }

    WritableMap event = Arguments.createMap();
    ReactContext reactContext = (ReactContext)getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
      getId(),
      keyEvent,
      event);
  }


  @Override
  public void onPause(PauseEvent pauseEvent) {
    WritableMap event = Arguments.createMap();
    ReactContext reactContext = (ReactContext)getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
      getId(),
      "onPause",
      event);
  }

  @Override
  public void onPlay(PlayEvent playEvent) {
    WritableMap event = Arguments.createMap();
    ReactContext reactContext = (ReactContext)getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
      getId(),
      "onPlay",
      event);
  }
}
