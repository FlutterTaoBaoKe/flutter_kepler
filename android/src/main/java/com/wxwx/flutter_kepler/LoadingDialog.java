package com.wxwx.flutter_kepler;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.wxwx.flutter_kepler.R;

public class LoadingDialog extends Dialog {

	private TextView tv;

	public LoadingDialog(Context context) {
		super(context, R.style.loadingDialogStyle);
	}
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dialogloading);
		tv = (TextView)findViewById(R.id.tv);
		tv.setText("加载");
		  LinearLayout linearLayout = (LinearLayout)this.findViewById(R.id.LinearLayout);
	      linearLayout.getBackground().setAlpha(210);  
	}

}

