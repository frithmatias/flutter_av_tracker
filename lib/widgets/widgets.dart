import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/models/search_results.dart';
import 'package:rutas_app/search/search_destination.dart';
import 'package:rutas_app/services/traffic_service.dart';
import 'package:polyline_do/polyline_do.dart' as poly;

part 'btn_ubicacion.dart';
part 'btn_mi_recorrido.dart';
part 'btn_seguir.dart';
part 'search.dart';
part 'marcador_manual.dart';