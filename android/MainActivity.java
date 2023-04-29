package com.example.mega_menu_app;

import androidx.appcompat.app.AppCompatActivity;


import android.os.AsyncTask;
import android.os.Bundle;

import android.widget.TextView;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    private TextView textViewResult_mon;
    private TextView textViewResult_tue;
    private TextView textViewResult_wed;
    private TextView textViewResult_thu;
    private TextView textViewResult_fri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        textViewResult_mon = findViewById(R.id.mega_menu_mon);
        textViewResult_tue = findViewById(R.id.mega_menu_tue);
        textViewResult_wed = findViewById(R.id.mega_menu_wed);
        textViewResult_thu = findViewById(R.id.mega_menu_thu);
        textViewResult_fri = findViewById(R.id.mega_menu_fri);
        new GetJsonData().execute("AWS Lambda API GateWay HTTP 주소");

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

                JSONObject jsonObject = new JSONObject(jsonData);
                String title = jsonObject.getString("images");
                title = title.substring(1, title.length()-1); // [] 제거

                JSONObject jsonObject1 = new JSONObject(title);
                String fields = jsonObject1.getString("fields");

                JSONArray jsonArray = new JSONArray(fields);

                for (int i=1; i < jsonArray.length(); i++) {
                    JSONObject subJsonObject = jsonArray.getJSONObject(i);
                    // String day_name = subJsonObject.getString("name");
                    String menu_info = subJsonObject.getString("inferText");

                    if (i == 1) {
                        textViewResult_mon.setText(menu_info);
                    }
                    else if (i == 2) {
                        textViewResult_tue.setText(menu_info);
                    }
                    else if (i == 3) {
                        textViewResult_wed.setText(menu_info);
                    }
                    else if (i == 4) {
                        textViewResult_thu.setText(menu_info);
                    }
                    else if (i == 5) {
                        textViewResult_fri.setText(menu_info);
                    }
                }

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }

}