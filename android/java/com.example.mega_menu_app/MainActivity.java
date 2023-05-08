package com.example.mega_menu_app;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.motion.widget.MotionLayout;

import android.content.Intent;
import android.os.Bundle;

import android.widget.TextView;

import org.json.JSONArray;
import java.util.Calendar;

public class MainActivity extends AppCompatActivity {

    private JSONArray data;
    private TextView[] menuList = new TextView[5];
    private TextView[] menuDate = new TextView[5];
    private TextView thisPeriod;

    private int dayOfWeek;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        thisPeriod = findViewById(R.id.this_week);

        menuList[0] = findViewById(R.id.mega_menu_mon);
        menuDate[0] = findViewById(R.id.mega_menu_mon_date);

        menuList[1] = findViewById(R.id.mega_menu_tue);
        menuDate[1] = findViewById(R.id.mega_menu_tue_date);

        menuList[2] = findViewById(R.id.mega_menu_wed);
        menuDate[2] = findViewById(R.id.mega_menu_wed_date);

        menuList[3] = findViewById(R.id.mega_menu_thu);
        menuDate[3] = findViewById(R.id.mega_menu_thu_date);

        menuList[4] = findViewById(R.id.mega_menu_fri);
        menuDate[4] = findViewById(R.id.mega_menu_fri_date);

        // Intent 에서 데이터 받기
        Intent intent = getIntent();
        for (int i = 0; i < menuList.length; i++){
            String menu_date = intent.getStringExtra("menu_date" + i);
            String menu_text = intent.getStringExtra("menu" + i);

            menuDate[i].setText(menu_date);
            menuList[i].setText(menu_text);
        }
        String period = intent.getStringExtra("thisPeriod");
        thisPeriod.setText(period);

        MotionLayout motionLayout = findViewById(R.id.motion_container);

        Calendar calendar = Calendar.getInstance();
        dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

        if (dayOfWeek == 3) { // 화요일
            motionLayout.setTransition(R.id.s1, R.id.s2);
            motionLayout.transitionToEnd();
        }
        else if (dayOfWeek == 4) { // 수요일
            motionLayout.setTransition(R.id.s1, R.id.s2);
            motionLayout.setTransition(R.id.s2, R.id.s3);
            motionLayout.transitionToEnd();
        }
        else if (dayOfWeek == 5) { // 목요일
            motionLayout.setTransition(R.id.s1, R.id.s2);
            motionLayout.setTransition(R.id.s2, R.id.s3);
            motionLayout.setTransition(R.id.s3, R.id.s4);
            motionLayout.transitionToEnd();
        }
        else if (dayOfWeek == 6) { // 금요일
            motionLayout.setTransition(R.id.s1, R.id.s2);
            motionLayout.setTransition(R.id.s2, R.id.s3);
            motionLayout.setTransition(R.id.s3, R.id.s4);
            motionLayout.setTransition(R.id.s4, R.id.s5);
            motionLayout.transitionToEnd();
        }

        else{ // 토요일, 일요일
            motionLayout.setTransition(R.id.s2, R.id.s1);
            motionLayout.transitionToEnd();
        }

    }

}