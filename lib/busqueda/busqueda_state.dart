part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {

  final bool seleccionManual;
  final bool seleccionConductor;
  final List<SearchResult> historial;


  BusquedaState({
    this.seleccionManual = false,
    this.seleccionConductor = false,
    List<SearchResult> historial
  }) : this.historial = (historial == null ) ? [] : historial;

  

  BusquedaState copyWith({
    bool seleccionManual,
    bool seleccionConductor,
    List<SearchResult> historial
  }) => BusquedaState(
    seleccionManual: seleccionManual ?? this.seleccionManual,
    seleccionConductor: seleccionConductor ?? this.seleccionConductor
  );
}



