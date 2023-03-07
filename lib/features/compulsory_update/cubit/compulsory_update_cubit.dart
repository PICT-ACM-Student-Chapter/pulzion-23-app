import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:package_info/package_info.dart';

part 'compulsory_update_state.dart';

class CompulsoryUpdateCubit extends Cubit<CompulsoryUpdateState> {
  CompulsoryUpdateCubit() : super(CompulsoryUpdateInitial());

  String getEnforcedVersion() {
    if (EndPoints.appLatestStableVersion == null) {
      return '1.0.0';
    } else {
      return EndPoints.appLatestStableVersion!;
    }
  }

  Future<void> needsUpdate() async {
    emit(CompulsoryUpdateLoading());
    
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final List<int> currentVersion =
        packageInfo.version.split('.').map((String number) => int.parse(number)).toList();
    final List<int> enforcedVersion =
        getEnforcedVersion().split('.').map((String number) => int.parse(number)).toList();
    for (int i = 0; i < 3; i++) {
      if (enforcedVersion[i] > currentVersion[i]) {
        emit(CompulsoryUpdateNeeded());
        return;
      }
    }
    emit(CompulsoryUpdateNotNeeded());
  }
}
