//
//  MVVMSampleNavigationViewModelInOut.swift
//  ModelViewWhateverSample
//
//  Created by yokoyas000 on 2018/04/18.
//  Copyright © 2018年 yokoyas000. All rights reserved.
//

// ViewModel:
//  - 内部表現を視覚表現へ変換する
//  - アクションを定義する
//  - アクションの結果/途中経過を受け取る
protocol MVVMSampleNavigationViewModelInput: MVVMSampleRootViewNavigationOutput, NavigationRequestModelReceiver {}

