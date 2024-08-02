part of 'general_bloc.dart';

class GeneralState extends Equatable {

  final int selectedBottomNavTab;
  final bool isInterentConnectionActive;

  const GeneralState({
    this.selectedBottomNavTab = 0,
    this.isInterentConnectionActive = true,
  });

  GeneralState copyWith({
    int? selectedBottomNavTab,
    bool? isInterentConnectionActive,
  }) => GeneralState(
    selectedBottomNavTab: selectedBottomNavTab ?? this.selectedBottomNavTab,
    isInterentConnectionActive: isInterentConnectionActive ?? this.isInterentConnectionActive,
  );
  
  @override
  List<Object> get props => [selectedBottomNavTab, isInterentConnectionActive];
}
