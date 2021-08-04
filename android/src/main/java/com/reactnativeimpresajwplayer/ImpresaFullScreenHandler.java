package com.reactnativeimpresajwplayer;

import android.app.Activity;
import android.content.pm.ActivityInfo;
import android.view.View;
import android.view.ViewGroup;

import com.jwplayer.pub.api.fullscreen.FullscreenHandler;
import com.jwplayer.pub.view.JWPlayerView;

public class ImpresaFullScreenHandler implements FullscreenHandler {
  private ViewGroup mPlayerContainer;
  private ViewGroup mRootView;
  private View mDecorView;
  private Activity activity;
  private ViewGroup parentViewGroup;
  private JWPlayerView jwPlayerView;

  public ImpresaFullScreenHandler(Activity activity, ViewGroup parentViewGroup, JWPlayerView jwPlayerView) {
    this.activity = activity;
    this.parentViewGroup = parentViewGroup;
    this.jwPlayerView = jwPlayerView;
  }

  @Override
  public void onFullscreenRequested() {
    mDecorView = activity.getWindow().getDecorView();
    mRootView = (ViewGroup) mDecorView.getRootView();
    mPlayerContainer = parentViewGroup;

    // Hide system ui
    mDecorView.setSystemUiVisibility(
      View.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hides bottom bar
        | View.SYSTEM_UI_FLAG_FULLSCREEN // hides top bar
        | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY // prevents navigation bar from overriding
      // exit-full-screen button. Swipe from side to access nav bar.
    );

    // Enter landscape mode for fullscreen videos
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);


    // Remove the JWPlayerView from the list item.
    if (mPlayerContainer != null) {
      mPlayerContainer.removeView(jwPlayerView);
    }

    // Add the JWPlayerView to the RootView as soon as the UI thread is ready.
    mRootView.post(new Runnable() {
      @Override
      public void run() {
        mRootView.addView(jwPlayerView, new ViewGroup.LayoutParams(
          ViewGroup.LayoutParams.MATCH_PARENT,
          ViewGroup.LayoutParams.MATCH_PARENT
        ));
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

    // Remove the player view from the root ViewGroup.
    mRootView.removeView(jwPlayerView);

    // As soon as the UI thread has finished processing the current message queue it
    mPlayerContainer.post(new Runnable() {
      @Override
      public void run() {
        mPlayerContainer.addView(jwPlayerView, new ViewGroup.LayoutParams(
          ViewGroup.LayoutParams.MATCH_PARENT,
          ViewGroup.LayoutParams.MATCH_PARENT
        ));
        jwPlayerView.layout(mPlayerContainer.getLeft(), mPlayerContainer.getTop(), mPlayerContainer.getRight(), mPlayerContainer.getBottom());
       // mFullscreenPlayer = jwPlayerView;
      }
    });
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
}
