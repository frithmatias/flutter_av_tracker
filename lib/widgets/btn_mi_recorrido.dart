part of 'widgets.dart';

class BtnMiRecorrido extends StatelessWidget {
  const BtnMiRecorrido({Key? key}) : super(key: key);

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
                      ? const Icon(Icons.linear_scale_outlined, color: Colors.blue, size: 30)
                      : const Icon(Icons.linear_scale_outlined, color: Colors.black45),
                  onPressed: () {
                    mapaBloc.add(OnMarcarRecorrido());
                  },
                )));
      },
    );
  }
}
