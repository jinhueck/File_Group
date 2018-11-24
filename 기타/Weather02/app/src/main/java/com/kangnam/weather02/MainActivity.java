package com.kangnam.weather02;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.EditText;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
    public void onClickHttp(View view) {
        (new AsyncTask<String, Void, String>() {
            protected String doInBackground(String... items) {
                String line = null;
                try {
                    URL Url = null;
                    Url = new URL(items[0]);
                    java.net.HttpURLConnection conn = null;
                    conn = (java.net.HttpURLConnection) Url.openConnection();
                    conn.setRequestMethod("GET");
                    InputStream is = conn.getInputStream();
                    BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                    line = reader.readLine();
                    System.out.println("----> data :" + line);
                } catch(Exception e)        {
                    e.printStackTrace();
                }
                return line;
            }

            protected void onPostExecute(String s) {
                JSONObject jObj = null;
                try {
                    jObj = new JSONObject(s);
                    JSONArray info = jObj.getJSONArray("info");
                    EditText etMemo = (EditText) findViewById(R.id.editText);
                    for(int i = 0 ; i < info.length() -1; i++) {
                        etMemo.append(info.getString(i) + "\n");
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }
        }).execute("http://172.16.11.71:8080/openapi.jsp?method=list");

        EditText etName = (EditText)findViewById(R.id.editText2);
        String name = etName.getText().toString();

        EditText etTag = (EditText)findViewById(R.id.editText3);
        String tag = etTag.getText().toString();;

        (new AsyncTask<String, Void, String>() {
            protected String doInBackground(String... items) {
                String line = null;
                try {
                    URL Url = null;
                    Url = new URL(items[0]);
                    java.net.HttpURLConnection conn = null;
                    conn = (java.net.HttpURLConnection) Url.openConnection();
                    conn.setRequestMethod("GET");
                    InputStream is = conn.getInputStream();
                    BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                    line = reader.readLine();
                    System.out.println("----> data :" + line);
                } catch(Exception e)        {
                    e.printStackTrace();
                }
                return line;
            }

            protected void onPostExecute(String s) {
                //
            }
        }).execute(
 "http://172.16.11.71:8080/openapi.jsp?method=add&name=" + name + "&tag=" + tag);




    }

    class HttpTask extends AsyncTask<String, Void, String> {
        protected String doInBackground(String... items) {
            System.out.println("--->" + items[0]);
            String line = null;
            try {
                URL Url = null; // http, ftp, rtp,
                Url = new URL(items[0]);
                java.net.HttpURLConnection conn = null;
                conn = (java.net.HttpURLConnection) Url.openConnection();
                conn.setRequestMethod("GET");
                InputStream is = conn.getInputStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                line = reader.readLine();
                System.out.println("----> data :" + line);
            } catch(Exception e)        {
                e.printStackTrace();
            }
                return line;
        }

        @Override
        protected void onPostExecute(String line) {
            try {
                JSONObject jObj = new JSONObject(line);
                JSONArray weathers = jObj.getJSONArray("weather");
                JSONObject weather = weathers.getJSONObject(0);
                String main = weather.getString("main");
                String icon = weather.getString("icon");
                System.out.println("날씨 :" + main);
                System.out.println("icon :" + icon);
                EditText etMemo = (EditText) findViewById(R.id.editText);
                etMemo.append("날씨 : " + main + "\n");
                etMemo.append("icon : " + icon + "\n");
            }catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}


