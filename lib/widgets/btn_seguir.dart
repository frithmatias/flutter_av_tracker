part of 'widgets.dart';

class BtnSeguir extends StatelessWidget {
  const BtnSeguir({Key? key}) : super(key: key);

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
                  icon: state.seguir
                      ? const Icon(Icons.visibility,
                          color: Colors.green, size: 30)
                      : const Icon(Icons.visibility, color: Colors.black45),
                  onPressed: () {
                    mapaBloc.add(OnSeguir());
                  },
                )));
      },
    );
  }
}
