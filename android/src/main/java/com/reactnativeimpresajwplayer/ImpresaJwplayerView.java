package com.reactnativeimpresajwplayer;

import android.app.Activity;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.appcompat.app.ActionBar;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.events.RCTEventEmitter;
import com.longtailvideo.jwplayer.JWPlayerView;
import com.longtailvideo.jwplayer.configuration.LogoConfig;
import com.longtailvideo.jwplayer.configuration.PlayerConfig;
import com.longtailvideo.jwplayer.events.FullscreenEvent;
import com.longtailvideo.jwplayer.events.PauseEvent;
import com.longtailvideo.jwplayer.events.PlayEvent;
import com.longtailvideo.jwplayer.events.listeners.VideoPlayerEvents;
import com.longtailvideo.jwplayer.fullscreen.FullscreenHandler;
import com.longtailvideo.jwplayer.media.ads.AdBreak;
import com.longtailvideo.jwplayer.media.ads.AdSource;
import com.longtailvideo.jwplayer.media.ads.Advertising;
import com.longtailvideo.jwplayer.media.playlists.PlaylistItem;

import java.lang.reflect.Constructor;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static com.longtailvideo.jwplayer.configuration.PlayerConfig.STRETCHING_EXACT_FIT;

public class ImpresaJwplayerView extends FrameLayout implements
  VideoPlayerEvents.OnFullscreenListener,
  VideoPlayerEvents.OnPlayListener,
  VideoPlayerEvents.OnPauseListener, LifecycleEventListener {

  //Props
  private String file = "";
  private String image = "";
  private String title = "";
  private String desc = "";
  private String mediaId = "";
  private Double volume = 100D;
  private Boolean autostart = false;
  private ReadableArray adSchedule = null;

  private ReactContext reactContext;
  private JWPlayerView mPlayerView;
  private PlaylistItem newPlayListItem;
  private PlayerConfig config;

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
    config = new PlayerConfig.Builder()
      .autostart(autostart).stretching(STRETCHING_EXACT_FIT)
      .build();

    mPlayerView.setup(config);
    createListeners();
    configurePlayList();

    mPlayerView.setFullscreenHandler(new FullscreenHandler() {
      private ViewGroup mPlayerContainer;
      private ViewGroup mRootView;
      private View mDecorView;

      @Override
      public void onFullscreenRequested() {
        mDecorView = activity.getWindow().getDecorView();
        mRootView = (ViewGroup) mDecorView.getRootView();
        mPlayerContainer = (ViewGroup) mPlayerView.getParent();

        // Hide system ui
        mDecorView.setSystemUiVisibility(
          View.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hides bottom bar
            | View.SYSTEM_UI_FLAG_FULLSCREEN // hides top bar
            | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY // prevents navigation bar from overriding
          // exit-full-screen button. Swipe from side to access nav bar.
        );

        // Enter landscape mode for fullscreen videos
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);

        mPlayerView.destroySurface();

        // Remove the JWPlayerView from the list item.
        if (mPlayerContainer != null) {
          mPlayerContainer.removeView(mPlayerView);
        }

        mPlayerView.initializeSurface();

        // Add the JWPlayerView to the RootView as soon as the UI thread is ready.
        mRootView.post(new Runnable() {
          @Override
          public void run() {
            mRootView.addView(mPlayerView, new ViewGroup.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT,
              ViewGroup.LayoutParams.MATCH_PARENT
            ));
            mPlayerView.pause();
          }
        });
      }

      @Override
      public void onFullscreenExitRequested() {
        mDecorView.setSystemUiVisibility(
          View.SYSTEM_UI_FLAG_VISIBLE // clear the hide system flags
        );

        // Enter portrait mode
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);

        mPlayerView.destroySurface();

        // Remove the player view from the root ViewGroup.
        mRootView.removeView(mPlayerView);


        mPlayerView.initializeSurface();

        // As soon as the UI thread has finished processing the current message queue it
        // should add the JWPlayerView back to the list item.
        mPlayerContainer.post(new Runnable() {
          @Override
          public void run() {
            mPlayerContainer.addView(mPlayerView, new ViewGroup.LayoutParams(
              ViewGroup.LayoutParams.MATCH_PARENT,
              ViewGroup.LayoutParams.MATCH_PARENT
            ));
            mPlayerView.layout(mPlayerContainer.getLeft(), mPlayerContainer.getTop(), mPlayerContainer.getRight(), mPlayerContainer.getBottom());
            mPlayerView.pause();
          }
        });
      }

      @Override
      public void onResume() {

      }

      @Override
      public void onPause() {

      }

      @Override
      public void onDestroy() {

      }

      @Override
      public void onAllowRotationChanged(boolean b) {

      }

      @Override
      public void updateLayoutParams(ViewGroup.LayoutParams layoutParams) {

      }

      @Override
      public void setUseFullscreenLayoutFlags(boolean b) {

      }
    });
  }

  private void createListeners(){
    // Handle hiding/showing of ActionBar
    mPlayerView.addOnFullscreenListener(this);
    mPlayerView.addOnPlayListener(this);
    mPlayerView.addOnPauseListener(this);
  }

  private void removeListners(){
    // Handle hiding/showing of ActionBar
    mPlayerView.removeOnFullscreenListener(this);
    mPlayerView.removeOnPlayListener(this);
    mPlayerView.removeOnPauseListener(this);
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

  public void setAdSchedule(ReadableArray adSchedule) {
    this.adSchedule = adSchedule;
    List<AdBreak> ads = new ArrayList<>();

    for (int i = 0; i < adSchedule.size(); i++) {
      ReadableMap adBreakProp = adSchedule.getMap(i);
      String offset = adBreakProp.hasKey("offset") ? adBreakProp.getString("offset") : "pre";
      if (adBreakProp.hasKey("tag")) {
        AdBreak adBreak = new AdBreak(offset, AdSource.VAST, adBreakProp.getString("tag"));
        ads.add(adBreak);
      }
    }

    newPlayListItem.setAdSchedule(ads);
    mPlayerView.load(newPlayListItem);
  }

  public void setAutoStart(Boolean autostart) {
    this.autostart = autostart;
    config.setAutostart(autostart);
    mPlayerView.setup(config);
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
    newPlayListItem.setMediaId(mediaId);
    mPlayerView.load(newPlayListItem);
  }

  @Override
  public void requestLayout() {
    super.requestLayout();
    post(measureAndLayout);
  }

  @Override
  protected void onDetachedFromWindow() {
    super.onDetachedFromWindow();
    mPlayerView.stop();
    removeListners();
    mPlayerView = null;
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
    Log.d("Rodrigo", "Como sei que deu certo");
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

  @Override
  public void onHostResume() {

  }

  @Override
  public void onHostPause() {

  }

  @Override
  public void onHostDestroy() {
    mPlayerView.stop();
    removeListners();
    mPlayerView = null;
  }
}
