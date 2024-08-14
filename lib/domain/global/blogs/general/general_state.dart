part of 'general_bloc.dart';

class GeneralState extends Equatable {

  final bool isLoading;
  final int selectedBottomNavTab;
  final bool isInterentConnectionActive;

  const GeneralState({
    this.isLoading = false,
    this.selectedBottomNavTab = 0,
    this.isInterentConnectionActive = true,
  });

  GeneralState copyWith({
    bool? isLoading,
    int? selectedBottomNavTab,
    bool? isInterentConnectionActive,
  }) => GeneralState(
    selectedBottomNavTab: selectedBottomNavTab ?? this.selectedBottomNavTab,
    isInterentConnectionActive: isInterentConnectionActive ?? this.isInterentConnectionActive,
  );
  
  @override
  List<Object> get props => [isLoading ,selectedBottomNavTab, isInterentConnectionActive];
}
