import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'contest_rules_state.dart';

class ContestRulesCubit extends Cubit<ContestRulesState> {
  ContestRulesCubit() : super(ContestRulesInitial());
}
