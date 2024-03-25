package com.example.mindtunes;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothManager;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import com.neurosky.AlgoSdk.NskAlgoDataType;
import com.neurosky.AlgoSdk.NskAlgoSdk;
import com.neurosky.AlgoSdk.NskAlgoSignalQuality;
import com.neurosky.AlgoSdk.NskAlgoState;
import com.neurosky.AlgoSdk.NskAlgoType;
import com.neurosky.connection.ConnectionStates;
import com.neurosky.connection.DataType.MindDataType;
import com.neurosky.connection.TgStreamHandler;
import com.neurosky.connection.TgStreamReader;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.EventSink;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

import io.flutter.embedding.android.FlutterActivity;

/** FlutterMindWaveMobile2Plugin */
public class FlutterMindWaveMobile2Plugin implements FlutterPlugin, MethodCallHandler {

  private static final String TAG = "MindWaveMobile2";
  private static final String NAMESPACE = "flutter_mindwave_mobile_2";

  private MethodChannel connectionChannel;
  private EventChannel algoStateAndReasonChannel;
  private EventChannel attentionChannel;
  private EventChannel bandPowerChannel;
  private EventChannel eyeBlinkChannel;
  private EventChannel meditationChannel;
  private EventChannel signalQualityChannel;

  private BluetoothManager mBluetoothManager;
  private BluetoothAdapter mBluetoothAdapter;

  private TgStreamReader mTgStreamReader;

  
  private NskAlgoSdk nskAlgoSdk;
  private short raw_data[] = new short[512];
  private int raw_data_index =  0;
  

  private TgStreamHandler callback = new TgStreamHandler() {

    @Override
    public void onStatesChanged(int connectionStates) {
      switch (connectionStates) {
        case ConnectionStates.STATE_CONNECTED:
          mTgStreamReader.start();
          connectionChannel.invokeMethod("connected", null);
          break;
        case ConnectionStates.STATE_DISCONNECTED:
          connectionChannel.invokeMethod("disconnected", null);
          break;
        case ConnectionStates.STATE_GET_DATA_TIME_OUT:
        case ConnectionStates.STATE_ERROR:
        case ConnectionStates.STATE_FAILED:
          disconnect();
          break;
        default:
          break;
      }
    }

    @Override
    public void onRecordFail(int flag) {
      // Handle the record error message here
      Log.e(TAG, "onRecordFail: " + flag);

    }

    @Override
    public void onChecksumFail(byte[] payload, int length, int checksum) {
      // Handle the bad packets here.
      Log.e(TAG, "onChecksumFail: " );
    }

    @Override
    public void onDataReceived(int datatype, int data, Object obj) {
      // Feed the raw data to algo sdk here
      switch (datatype) {
        case MindDataType.CODE_ATTENTION:
          short[] attValue = { (short) data };
          nskAlgoSdk.NskAlgoDataStream(NskAlgoDataType.NSK_ALGO_DATA_TYPE_ATT.value, attValue, 1);
          break;
        case MindDataType.CODE_MEDITATION:
          short[] medValue = { (short) data };
          nskAlgoSdk.NskAlgoDataStream(NskAlgoDataType.NSK_ALGO_DATA_TYPE_MED.value, medValue, 1);
          break;
        case MindDataType.CODE_POOR_SIGNAL:
          short[] psValue = { (short) data };
          nskAlgoSdk.NskAlgoDataStream(NskAlgoDataType.NSK_ALGO_DATA_TYPE_PQ.value, psValue, 1);
          break;
        case MindDataType.CODE_RAW:
          raw_data[raw_data_index++] = (short) data;
          if (raw_data_index == 512) {
            nskAlgoSdk.NskAlgoDataStream(NskAlgoDataType.NSK_ALGO_DATA_TYPE_EEG.value, raw_data, raw_data_index);
            raw_data_index = 0;
          }
          break;
        default:
          break;
      }
    }

  };


  private EventSink algoStateAndReasonChannelSink;
  private final StreamHandler algoStateAndReasonChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      algoStateAndReasonChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      algoStateAndReasonChannelSink = null;
    }
  };

  private EventSink attentionChannelSink;
  private final StreamHandler attentionChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      attentionChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      attentionChannelSink = null;
    }
  };

  private EventSink bandPowerChannelSink;
  private final StreamHandler bandPowerChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      bandPowerChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      bandPowerChannelSink = null;
    }
  };

  private EventSink eyeBlinkChannelSink;
  private final StreamHandler eyeBlinkChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      eyeBlinkChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      eyeBlinkChannelSink = null;
    }
  };

  private EventSink meditationChannelSink;
  private final StreamHandler meditationChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      meditationChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      meditationChannelSink = null;
    }
  };

  private EventSink signalQualityChannelSink;
  private final StreamHandler signalQualityChannelHandler = new StreamHandler() {
    @Override
    public void onListen(Object o, EventSink eventSink) {
      signalQualityChannelSink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
      signalQualityChannelSink = null;
    }
  };


  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    Log.d(TAG, "onAttachedToEngine: Invoked");
    BinaryMessenger messenger = binding.getBinaryMessenger();
    connectionChannel = new MethodChannel(messenger, NAMESPACE + "/connection");
    algoStateAndReasonChannel = new EventChannel(messenger, NAMESPACE+"/algoStateAndReason");
    attentionChannel = new EventChannel(messenger, NAMESPACE+"/attention");
    bandPowerChannel = new EventChannel(messenger, NAMESPACE+"/bandPower");
    eyeBlinkChannel = new EventChannel(messenger, NAMESPACE+"/eyeBlink");
    meditationChannel = new EventChannel(messenger, NAMESPACE+"/meditation");
    signalQualityChannel = new EventChannel(messenger, NAMESPACE+"/signalQuality");
    mBluetoothManager = (BluetoothManager) binding.getApplicationContext().getSystemService(Context.BLUETOOTH_SERVICE);
    mBluetoothAdapter = mBluetoothManager.getAdapter();
    connectionChannel.setMethodCallHandler(this);
    algoStateAndReasonChannel.setStreamHandler(algoStateAndReasonChannelHandler);
    attentionChannel.setStreamHandler(attentionChannelHandler);
    bandPowerChannel.setStreamHandler(bandPowerChannelHandler);
    eyeBlinkChannel.setStreamHandler(eyeBlinkChannelHandler);
    meditationChannel.setStreamHandler(meditationChannelHandler);
    signalQualityChannel.setStreamHandler(signalQualityChannelHandler);
    
    setupNskAlgoSk();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    try {
      switch(call.method)
      {
       
        case "connect":
       
          String deviceId = call.argument("deviceId");
          connect(deviceId);
          result.success(null);
          break;
        case "disconnect":
          disconnect();
          result.success(null);
          break;
        default:
          result.notImplemented();
      }
    } catch (Exception error) {
      result.error(error.getLocalizedMessage(), error.getStackTrace().toString(), null);
    }
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {
    connectionChannel.setMethodCallHandler(null);
  }

  private void connect(String deviceId) {
    BluetoothDevice remoteDevice = mBluetoothAdapter.getRemoteDevice(deviceId);
    if (mTgStreamReader == null) {
      mTgStreamReader = new TgStreamReader(remoteDevice, callback);
      mTgStreamReader.connect();
    }
  }

  private void disconnect() {
    if (mTgStreamReader != null && mTgStreamReader.isBTConnected()) {
      mTgStreamReader.stop();
      mTgStreamReader.close();
      mTgStreamReader = null;
    }
  }

  private void setupNskAlgoSk() {
    nskAlgoSdk = new NskAlgoSdk();

    nskAlgoSdk.setOnStateChangeListener(new NskAlgoSdk.OnStateChangeListener() {
      @Override
      public void onStateChange(int state, int reason) {
        String stateStr = "";
        String reasonStr = "";
        for (NskAlgoState s : NskAlgoState.values()) {
          if (s.value == state) {
            stateStr = s.toString();
          }
        }
        for (NskAlgoState r : NskAlgoState.values()) {
          if (r.value == reason) {
            reasonStr = r.toString();
          }
        }
        if(algoStateAndReasonChannelSink != null) {
          Map<String,String> algoStateAndReasonMap = new HashMap<>();
          algoStateAndReasonMap.put("state", stateStr);
          algoStateAndReasonMap.put("reason", reasonStr);
          JSONObject json = new JSONObject(algoStateAndReasonMap);
          Log.d(TAG, json.toString());
          algoStateAndReasonChannelSink.success(json.toString());
        }
      }
    });

    nskAlgoSdk.setOnAttAlgoIndexListener(new NskAlgoSdk.OnAttAlgoIndexListener() {
      @Override
      public void onAttAlgoIndex(int attentionValue) {
        if(attentionChannelSink != null) {
          attentionChannelSink.success(attentionValue);
        }
      }
    });

    nskAlgoSdk.setOnBPAlgoIndexListener(new NskAlgoSdk.OnBPAlgoIndexListener() {
      @Override
      public void onBPAlgoIndex(float delta, float theta, float alpha, float beta, float gamma) {
        if(bandPowerChannelSink != null) {
          Map<String,String> bandPowerValues = new HashMap<>();
          bandPowerValues.put("delta", String.valueOf(delta));
          bandPowerValues.put("theta", String.valueOf(theta));
          bandPowerValues.put("alpha", String.valueOf(alpha));
          bandPowerValues.put("beta", String.valueOf(beta));
          bandPowerValues.put("gamma", String.valueOf(gamma));
          JSONObject json = new JSONObject(bandPowerValues);
          bandPowerChannelSink.success(json.toString());
        }
      }
    });

    nskAlgoSdk.setOnEyeBlinkDetectionListener(new NskAlgoSdk.OnEyeBlinkDetectionListener() {
      @Override
      public void onEyeBlinkDetect(int eyeBlinkStrengthValue) {
        if(eyeBlinkChannelSink != null) {
          eyeBlinkChannelSink.success(eyeBlinkStrengthValue);
        }
      }
    });

    nskAlgoSdk.setOnMedAlgoIndexListener(new NskAlgoSdk.OnMedAlgoIndexListener() {
      @Override
      public void onMedAlgoIndex(int meditationValue) {
        if(meditationChannelSink != null) {
          meditationChannelSink.success(meditationValue);
        }
      }
    });

    nskAlgoSdk.setOnSignalQualityListener(new NskAlgoSdk.OnSignalQualityListener() {
      @Override
      public void onSignalQuality(int signalQualityLevel) {
        if(signalQualityChannelSink != null) {
          signalQualityChannelSink.success(signalQualityLevel);
        }
      }
    });

    int algoTypes = NskAlgoType.NSK_ALGO_TYPE_ATT.value +
            NskAlgoType.NSK_ALGO_TYPE_MED.value +
            NskAlgoType.NSK_ALGO_TYPE_BP.value +
            NskAlgoType.NSK_ALGO_TYPE_BLINK.value;
    nskAlgoSdk.NskAlgoInit(algoTypes, "");
    nskAlgoSdk.NskAlgoStart(false);
  }

}
