import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../../constants/urls.dart';

part 'compulsory_update_state.dart';

class CompulsoryUpdateCubit extends Cubit<CompulsoryUpdateState> {
  CompulsoryUpdateCubit() : super(CompulsoryUpdateLoading());

  String getEnforcedVersion() {
    return EndPoints.appLatestStableVersion == null
        ? '1.0.0'
        : EndPoints.appLatestStableVersion!;
  }

  Future<void> needsUpdate() async {
    emit(CompulsoryUpdateNotNeeded());
    return;
    
    emit(CompulsoryUpdateLoading());
    log(EndPoints.appLatestStableVersion.toString());

    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final List<int> currentVersion = packageInfo.version
        .split('.')
        .map((String number) => int.parse(number))
        .toList();
    final List<int> enforcedVersion = getEnforcedVersion()
        .split('.')
        .map((String number) => int.parse(number))
        .toList();
    for (int i = 0; i < 3; i++) {
      if (enforcedVersion[i] > currentVersion[i]) {
        emit(CompulsoryUpdateNeeded());

        return;
      }
    }
    emit(CompulsoryUpdateNotNeeded());
  }
}
