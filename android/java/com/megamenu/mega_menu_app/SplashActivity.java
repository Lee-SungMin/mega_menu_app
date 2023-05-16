package com.megamenu.mega_menu_app;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;

import android.os.Handler;
import android.widget.ImageView;


import com.bumptech.glide.Glide;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class SplashActivity extends AppCompatActivity {

    private JSONArray data;
    private String[] menuList = new String[5];
    private String[] menuDate = new String[5];
    private String thisPeriod;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        ImageView gif_image = (ImageView) findViewById(R.id.gif_image);
        Glide.with(this).load(R.drawable.mega_menu_loading_cat).into(gif_image);

        // AsyncTask를 사용하여 데이터를 받아오는 작업을 처리
        new SplashActivity.GetJsonData().execute("AWS Gateway URL");

    }

    private class GetJsonData extends AsyncTask<String, Void, String> {

        @Override
        protected String doInBackground(String... urls) {
            String jsonData = "";
            try {
                URL url = new URL(urls[0]);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                InputStream inputStream = conn.getInputStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonData += line;
                }
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return jsonData;
        }

        @Override
        protected void onPostExecute(String jsonData) {
            super.onPostExecute(jsonData);
            try {
                data = new JSONArray(jsonData);

                for (int i=0; i < data.length(); i++) {
                    JSONObject item = data.getJSONObject(i);
                    String menu = item.getString("Menu"); // Menu 키 값

                    int index = menu.indexOf("\n"); // 첫번째 개행문자의 인덱스를 찾음

                    if (index != -1) {
                        String menu_date = menu.substring(0, index).split(" ")[1] + " " + menu.substring(0, index).split(" ")[2]; // 첫번째 개행문자 앞쪽 문자열 + 앞의 index를 제외한 날짜+요일 추출
                        String menu_text = menu.substring(index + 1); // 첫번째 개행문자 뒤쪽 문자열 추출

                        menuDate[i] = menu_date;
                        menuList[i] = menu_text;
                    }

                    else{
                        menuDate[i] = menu;
                        menuList[i] = "";
                    }


                    if (i == 0){
                        String period = item.getString("Period"); // Period 키 값
                        thisPeriod = "구내식당 " + period + " 메뉴 🧑‍🍳";
                    }
                }

                Handler handler = new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {

                        Intent intent = new Intent(SplashActivity.this, MainActivity.class);

                        for (int i = 0; i < menuList.length; i++){
                            intent.putExtra("menu_date" + i, menuDate[i]);
                            intent.putExtra("menu" + i, menuList[i]);
                        }
                        intent.putExtra("thisPeriod", thisPeriod);
                        startActivity(intent);
                        finish();
                    }
                }, 4000);  // 로딩화면 시간

        } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }
}