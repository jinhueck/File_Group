package com.example.qorgh.bluetooth_tech;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.Handler;
import android.util.Log;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

/**
 * Created by qorgh on 2018-01-08.
 */

public class BluetoothService {
    private static final String TAG = "BluetoothService";


    private static final int REQUEST_CONNECT_DEVICE = 1;
    private static final int REQUEST_ENABLE_BT = 2;

    //-------------------------------------------------------
    private static final UUID MY_UUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    private class ConnectThread extends Thread {
        private final BluetoothSocket mmSocket;
        private final BluetoothDevice mmDevice;

        public ConnectThread(BluetoothDevice device) {
            mmDevice = device;
            BluetoothSocket tmp = null; // 디바이스 정보를 얻어서 BluetoothSocket 생성
            try {
                tmp = device.createRfcommSocketToServiceRecord(MY_UUID);
            } catch (IOException e) {
                Log.e(TAG, "create() failed", e);
            }
            mmSocket = tmp;
        }

        public void run() {
            Log.i(TAG, "BEGIN mConnectThread");
            setName("ConnectThread");

            // 연결을 시도하기 전에는 항상 기기 검색을 중지한다.
            // 기기 검색이 계속되면 연결속도가 느려지기 때문이다.
            btAdapter.cancelDiscovery();

            // BluetoothSocket 연결 시도
            try {
                // BluetoothSocket 연결 시도에 대한 return 값은 succes 또는 exception이다.
                mmSocket.connect();
                Log.d(TAG, "Connect Success");
            } catch (IOException e) {
                connectionFailed();    // 연결 실패시 불러오는 메소드
                Log.d(TAG, "Connect Fail");
                // socket을 닫는다.
                try {
                    mmSocket.close();
                } catch (IOException e2) {
                    Log.e(TAG, "unable to close() socket during connection failure", e2);
                }

                // 연결중? 혹은 연결 대기상태인 메소드를 호출한다.
                BluetoothService.this.start();
                return;
            }

            // ConnectThread 클래스를 reset한다.
            synchronized (BluetoothService.this) {
                mConnectThread = null;
            }
            // ConnectThread를 시작한다.
            connected(mmSocket, mmDevice);
        }

        public void cancel() {
            try {
                mmSocket.close();
            } catch (IOException e) {
                Log.e(TAG, "close() of connect socket failed", e);
            }
        }
    }




    //------------------------------------------------------

    public BluetoothService(Activity ac, Handler h) {
        mActivity = ac;
        mHandler = h;
        // BluetoothAdapter 얻기
        btAdapter = BluetoothAdapter.getDefaultAdapter();
    }
    public boolean getDeviceState(){
        if(btAdapter == null){
            Log.d(TAG, "Bluetooth is not availabled");
            return  false;
        }
        else{
            Log.d(TAG, "Bluetooth is availabled");
            return  true;
        }
    }
    public void enableBluetooth(){
        if(btAdapter.isEnabled()){
            scanDevice();
        }
        else {
            Intent i = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            mActivity.startActivityForResult(i,REQUEST_ENABLE_BT);
        }
    }
    public void scanDevice(){
        Intent serverIntent = new Intent(mActivity, DeviceListActivity.class);
        mActivity.startActivityForResult(serverIntent, REQUEST_CONNECT_DEVICE);
    }
    public void getDeviceInfo(Intent data) {
        // Get the device MAC address
        String address = data.getExtras().getString(DeviceListActivity.EXTRA_DEVICE_ADDRESS);
        // Get the BluetoothDevice object
        // BluetoothDevice device = btAdapter.getRemoteDevice(address);
        BluetoothDevice device = btAdapter.getRemoteDevice(address);
        Log.d(TAG, "Get Device Info \n" + "address : " + address);
        connect(device);
    }
//------------------------------------------------------------------

    private BluetoothAdapter btAdapter;
    private Activity mActivity;
    private Handler mHandler;
    private ConnectThread mConnectThread; // 변수명 다시
    private ConnectedThread mConnectedThread; // 변수명 다시
    private class ConnectedThread extends Thread {
        private final BluetoothSocket mmSocket;
        private final InputStream mmInStream;
        private final OutputStream mmOutStream;
        public ConnectedThread(BluetoothSocket socket) {
            Log.d(TAG, "create ConnectedThread");
            mmSocket = socket;
            InputStream tmpIn = null;
            OutputStream tmpOut = null;
            // BluetoothSocket의 inputstream 과 outputstream을 얻는다.
            try {
                tmpIn = socket.getInputStream();
                tmpOut = socket.getOutputStream();
            } catch (IOException e) {
                Log.e(TAG, "temp sockets not created", e);
            }
            mmInStream = tmpIn; mmOutStream = tmpOut;
        }
        public void run() {
            Log.i(TAG, "BEGIN mConnectedThread");
            byte[] buffer = new byte[1024];
            int bytes;
            // Keep listening to the InputStream while connected
            while (true) {
                try {
                    // InputStream으로부터 값을 받는 읽는 부분(값을 받는다)
                    bytes = mmInStream.read(buffer);
                } catch (IOException e) {
                    Log.e(TAG, "disconnected", e);
                    connectionLost();
                    break;
                }
            }
        } /** * Write to the connected OutStream. * @param buffer The bytes to write */
        public void write(byte[] buffer) {
            try {
                // 값을 쓰는 부분(값을 보낸다)
                mmOutStream.write(buffer);
            }
            catch (IOException e) { Log.e(TAG, "Exception during write", e);
            }
        }
        public void cancel() {
            try {
                mmSocket.close();
            }
            catch (IOException e) {
                Log.e(TAG, "close() of connect socket failed", e);
            }
        }
    }
    private int mState;
    private static final int STATE_NONE = 0; // we're doing nothing
    private static final int STATE_LISTEN = 1; // now listening for incoming connections
    private static final int STATE_CONNECTING = 2; // now initiating an outgoing connection
    private static final int STATE_CONNECTED = 3; // now connected to a remote device

    private  synchronized void setState(int state){
        mState = state;
    }

    public synchronized  int getState(){
        return mState;
    }

    public synchronized void start(){
        if(mConnectThread == null){
        }
        else {
            mConnectThread.cancel();;
            mConnectThread = null;
        }
        if(mConnectedThread == null){

        }
        else
        {
            mConnectedThread.cancel();
            mConnectedThread = null;
        }
    }
    public  synchronized void connect(BluetoothDevice device){
        if(mState == STATE_CONNECTING){
            if(mConnectThread == null){

            }
            else{
                mConnectThread.cancel();
                mConnectThread = null;
            }

            if(mConnectedThread == null){

            }
            else {
                mConnectedThread.cancel();
                mConnectedThread = null;
            }

            mConnectThread = new ConnectThread(device);

            mConnectThread.start();
            setState(STATE_CONNECTING);
        }
    }
    public synchronized  void connected(BluetoothSocket socket, BluetoothDevice device){

        if(mConnectThread == null){

        }
        else{
            mConnectThread.cancel();
            mConnectThread = null;
        }

        if(mConnectedThread == null){

        }
        else {
            mConnectedThread.cancel();
            mConnectedThread = null;
        }

        mConnectedThread = new ConnectedThread(socket);
        mConnectedThread.start();

        setState(STATE_CONNECTED);
    }

    public synchronized void stop(){
        if(mConnectThread != null){
            mConnectedThread.cancel();
            mConnectedThread = null;
        }
        if(mConnectedThread != null){
            mConnectedThread.cancel();
            mConnectedThread = null;
        }

        setState(STATE_NONE);
    }

    public void write(byte[] out){
        ConnectedThread r;
        synchronized (this){
            if(mState != STATE_CONNECTED)
                return;
            r = mConnectedThread;
        }
    }
    private  void connectionFailed(){ // 연결 실패했을때
        setState(STATE_LISTEN);
    }

    private  void connectionLost(){
        setState(STATE_LISTEN);
    }
}
