part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapaBloc = context.read<MapaBloc>();

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 25,
                child: IconButton(
                  icon: state.dibujarRecorrido
                      ? const Icon(Icons.explore, color: Colors.blue)
                      : const Icon(Icons.explore_off, color: Colors.black45),
                  onPressed: () {
                    mapaBloc.add(OnMarcarRecorrido());
                  },
                )));
      },
    );
  }
}
