// The MIT License (MIT)
//
// Copyright (c) 2019 Reflect Code Technologies (OPC) Pvt. Ltd. (http://ReflectCode.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software
// and associated documentation files (the "Software"), to deal in the Software without restriction,
// including without limitation the rights to use, copy, modify, merge, publish, distribute,
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package com.rc.demo.glide;


import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.os.AsyncTask;
import android.widget.ImageView;
import android.graphics.drawable.ColorDrawable;
import android.support.v7.app.AppCompatActivity;

import com.bumptech.glide.Glide;
import com.bumptech.glide.Priority;
import com.bumptech.glide.request.RequestOptions;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.request.target.BitmapImageViewTarget;

import com.bumptech.glide.TransitionOptions;
import com.bumptech.glide.load.MultiTransformation;
import com.bumptech.glide.load.resource.bitmap.FitCenter;
import com.bumptech.glide.load.resource.bitmap.CircleCrop;
import com.bumptech.glide.load.resource.bitmap.CenterCrop;
import com.bumptech.glide.load.resource.bitmap.CenterInside;
import com.bumptech.glide.request.transition.Transition;

import static com.bumptech.glide.load.resource.bitmap.BitmapTransitionOptions.withWrapped;
import static com.bumptech.glide.load.resource.drawable.DrawableTransitionOptions.withCrossFade;

/*
Image URLs
    1200 * 1600 : https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg
     675 *  900 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/675px-Apus_apus_01.jpg
     360 *  480 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/360px-Apus_apus_01.jpg
     109 *  145 : https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Apus_apus_01.jpg/109px-Apus_apus_01.jpg

    https://aggie-horticulture.tamu.edu/wildseed/flowers/AlamoFire.jpg
*/

public class MainActivity extends AppCompatActivity {

    ImageView imgView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        imgView = (ImageView) findViewById(R.id.imgView);
    }

    void btnLoadFromResClick(View v){
        Glide.with(this).load(R.drawable.contact_eight).into(imgView);
    }

    void btnLoadFromURLClick(View v){
        Glide.with(this).load(Uri.parse("https://aggie-horticulture.tamu.edu/wildseed/flowers/AlamoFire.jpg")).placeholder(R.drawable.rc_help).transition(withCrossFade(3)).into(imgView);
    }

    void btnLoadWithOptions(View v){
        RequestOptions opt = new RequestOptions().circleCrop().placeholder(R.drawable.rc_help);
        opt.priority(Priority.HIGH);
        opt.diskCacheStrategy(DiskCacheStrategy.AUTOMATIC);
        Glide.with(this).load(Uri.parse("https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg")).apply(opt).into(imgView);
    }

    void btnLoadInBitmapImageViewTarget(View v){
        Glide.with(this)
                .asBitmap()
                .load(Uri.parse("https://upload.wikimedia.org/wikipedia/commons/d/dd/Apus_apus_01.jpg"))
                .into(new BitmapImageViewTarget(imgView) {
                    @Override
                    public void onResourceReady(Bitmap bitmap, @Nullable Transition<? super Bitmap> transition) {
                        super.onResourceReady(bitmap, transition);
                        Log.i("RC", "bitmap.size = (" + bitmap.getHeight() + "," + bitmap.getWidth() + ")");
                    }
                });
    }

    void btnLoadWithCircleCrop(View v){
        Glide.with(this).load(R.drawable.contact_ten).circleCrop().into(imgView);
    }

    void btnLoadWithCrossFade3Sec(View v){
        Glide.with(this)
                .load(R.drawable.contact_six).circleCrop()
                .priority(Priority.HIGH)
                .diskCacheStrategy(DiskCacheStrategy.AUTOMATIC)
                .transition(withCrossFade(3)).into(imgView);
    }

    void btnLoadCrossFade(View v){
        Glide.with(this).load(R.drawable.contact_three).transition(withCrossFade()).into(imgView);
    }

    void btnLoadColor(View v){
        Glide.with(this).load(new ColorDrawable(getResources().getColor(R.color.colorPrimary, null))).into(imgView);
    }


    void btnClearDiskCache(View v){
        // Clear the memory
        Glide.get(getApplicationContext()).clearMemory();

    }
}