package com.reactnativeimpresajwplayer;

import android.app.ActionBar;
import android.app.Activity;
import android.content.Context;
import android.media.AudioManager;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;

import androidx.constraintlayout.widget.ConstraintLayout;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.jwplayer.pub.api.JWPlayer;
import com.jwplayer.pub.api.configuration.PlayerConfig;
import com.jwplayer.pub.api.configuration.ads.VastAdvertisingConfig;
import com.jwplayer.pub.api.events.DisplayClickEvent;
import com.jwplayer.pub.api.events.EventType;
import com.jwplayer.pub.api.events.FullscreenEvent;
import com.jwplayer.pub.api.events.PauseEvent;
import com.jwplayer.pub.api.events.PlayEvent;
import com.jwplayer.pub.api.events.listeners.VideoPlayerEvents;
import com.jwplayer.pub.api.media.ads.AdBreak;
import com.jwplayer.pub.api.media.playlists.PlaylistItem;
import com.jwplayer.pub.view.JWPlayerView;
import java.util.ArrayList;
import java.util.List;

public class ImpresaJwplayerView extends ConstraintLayout implements
  VideoPlayerEvents.OnFullscreenListener,
  VideoPlayerEvents.OnPlayListener,
  VideoPlayerEvents.OnPauseListener,
  VideoPlayerEvents.OnDisplayClickListener,
  LifecycleEventListener,
  AudioManager.OnAudioFocusChangeListener
{

  //Props
  private String file = "";
  private String image = "";
  private String title = "";
  private String desc = "";
  private String mediaId = "";
  private Double volume = 100D;
  private Boolean autostart = false;
  private Activity currentActivity = null;
  private ReactContext reactContext;
  private ImpresaJwplayerComponent mPlayerView;
  private PlaylistItem playListItem;
  private PlayerConfig config;
  private JWPlayer player;

  public ImpresaJwplayerView(Context context) {
    super(context);
    reactContext = (ReactContext) context;
  }

  public ImpresaJwplayerView(Context context, Activity activity) {
    super(context);
    reactContext = (ReactContext) context;
    currentActivity = activity;
    mPlayerView = new ImpresaJwplayerComponent(activity);

    setLayoutParams(new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.MATCH_PARENT));
    mPlayerView.setLayoutParams(new RelativeLayout.LayoutParams(
      RelativeLayout.LayoutParams.MATCH_PARENT,
      RelativeLayout.LayoutParams.MATCH_PARENT));

    // Add the JWPlayerView to the screen. Make sure it's 16:9.
    DisplayMetrics metrics = new DisplayMetrics();
    activity.getWindowManager().getDefaultDisplay().getMetrics(metrics);

    ConstraintLayout jwPlayerLayout = (ConstraintLayout) currentActivity.getLayoutInflater().inflate(R.layout.jwplayer_view, null);
    this.addView(mPlayerView, new ConstraintLayout.LayoutParams(
      ViewGroup.LayoutParams.MATCH_PARENT, metrics.widthPixels / 16 * 9));

    player = mPlayerView.getPlayer();

    // Keep the screen on during playback
    new ImpresaKeepScreenOnHandler(player, activity.getWindow());

    config = new PlayerConfig.Builder()
      .stretching(PlayerConfig.STRETCHING_EXACT_FIT)
      .build();

    player.setup(config);
    createListeners();
    reactContext.addLifecycleEventListener(this);
    player.allowBackgroundAudio(false);
    playListItem = new PlaylistItem.Builder().build();
  }

  public void destroyPlayer(){
    player.stop();
    removeListners();
    player = null;
  }

  @Override
  protected void onDetachedFromWindow() {
    super.onDetachedFromWindow();
  }

  private void createListeners(){
    player.addListener(EventType.FULLSCREEN, this);
    player.addListener(EventType.PLAY, this);
    player.addListener(EventType.PAUSE, this);
    player.addListener(EventType.DISPLAY_CLICK, this);
  }

  private void removeListners(){
    player.removeListener(EventType.FULLSCREEN, this);
    player.removeListener(EventType.PLAY, this);
    player.removeListener(EventType.PAUSE, this);
    player.removeListener(EventType.DISPLAY_CLICK, this);
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

  public JWPlayer getPlayer() {
    return player;
  }

  public void setAdSchedule(ReadableArray adSchedule) {
    List<AdBreak> ads = new ArrayList<>();

    for (int i = 0; i < adSchedule.size(); i++) {
      ReadableMap adBreakProp = adSchedule.getMap(i);
      String offset = adBreakProp.hasKey("offset") ? adBreakProp.getString("offset") : "pre";
      if (adBreakProp.hasKey("tag")) {
        AdBreak adBreak =  new AdBreak.Builder().tag(adBreakProp.getString("tag")).offset(offset).build();
        ads.add(adBreak);
      }
    }

    VastAdvertisingConfig advertisingConfig = new VastAdvertisingConfig.Builder()
      .schedule(ads)
      .build();

    config = new PlayerConfig.Builder(config)
      .advertisingConfig(advertisingConfig)
      .build();
    player.stop();
    player.setup(config);
  }

  public void setAutoStart(Boolean autostart) {
    this.autostart = autostart;
    config = new PlayerConfig.Builder(config)
      .autostart(autostart)
      .build();
    player.stop();
    player.setup(config);
  }

  public void setFile(String file) {
    this.file = file;
    playListItem = new PlaylistItem.Builder(playListItem)
      .file(file)
      .build();

    List<PlaylistItem> playlist = new ArrayList<>();
    playlist.add(playListItem);

    config = new PlayerConfig.Builder(config)
      .playlist(playlist)
      .build();
    player.stop();
    player.setup(config);
  }

  public void setImage(String image) {
    playListItem = new PlaylistItem.Builder(playListItem)
      .image(image)
      .build();

    List<PlaylistItem> playlist = new ArrayList<>();
    playlist.add(playListItem);

    config = new PlayerConfig.Builder(config)
      .playlist(playlist)
      .build();
    player.stop();
    player.setup(config);
  }

  public void setTitle(String title) {
    this.title = title;
    playListItem = new PlaylistItem.Builder(playListItem)
      .title(title)
      .build();

    List<PlaylistItem> playlist = new ArrayList<>();
    playlist.add(playListItem);

    config = new PlayerConfig.Builder(config)
      .playlist(playlist)
      .build();

    player.stop();
    player.setup(config);
  }

  public void setDesc(String desc) {
    this.desc = desc;
    playListItem = new PlaylistItem.Builder(playListItem)
      .description(desc)
      .build();

    List<PlaylistItem> playlist = new ArrayList<>();
    playlist.add(playListItem);

    config = new PlayerConfig.Builder(config)
      .playlist(playlist)
      .build();

    player.stop();
    player.setup(config);
  }

  public void setMediaId(String mediaId) {
    this.mediaId = mediaId;
    playListItem = new PlaylistItem.Builder(playListItem)
      .mediaId(mediaId)
      .build();

    List<PlaylistItem> playlist= new ArrayList<>();
    playlist.add(playListItem);

    config = new PlayerConfig.Builder(config)
      .playlist(playlist)
      .build();

    player.stop();
    player.setup(config);
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
    ActionBar actionBar = reactContext.getCurrentActivity().getActionBar();
    if (fullscreenEvent.getFullscreen()) {
      keyEvent = "onFullScreen";

      if(actionBar != null){
        actionBar.hide();
      }

    } else {
      keyEvent = "onFullScreenExit";
      if(actionBar != null){
        actionBar.show();
      }
      player.pause();
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

  @Override
  public void onHostResume() {
    Log.d("JwPlayer Impresa", "resume");
  }

  @Override
  public void onHostPause() {
    Log.d("JwPlayer Impresa", "pause");
  }

  @Override
  public void onHostDestroy() {
    player.stop();
    removeListners();
    mPlayerView = null;
    this.destroyPlayer();
  }

  @Override
  public void onAudioFocusChange(int focusChange) {
    Log.d("JwPlayer Impresa", "onaudio");
  }

  @Override
  public void onDisplayClick(DisplayClickEvent displayClickEvent) {
    Log.d("JwPlayer Impresa", "onDisplayClick");
  }
}
