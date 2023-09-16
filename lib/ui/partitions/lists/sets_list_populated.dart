part of 'package:playground/ui/sets_page.dart';

class SetsList extends StatelessWidget {
  SetsList({Key? key, List<sets_models.Set>? sets, SetsRequest? request})
      : sets = sets ?? <sets_models.Set>[],
        request = request ?? SetsRequest(),
        super(key: key);

  final List<sets_models.Set> sets;
  final SetsRequest request;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      onRefresh: () async {
        context.read<SetsPageCubit>().fetchSets(request);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: sets.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                title: Text(sets[index].name ?? ''),
                children: [
                  ListTile(
                    title: Text('Release date: ${sets[index].releaseDate}'),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text('See cards'),
                        SizedBox(
                            height: 25,
                            width: 25,
                            child:
                                Image.asset('assets/images/double_arrow.png'))
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardsPage(
                                  set: sets[index],
                                )),
                      );
                    },
                  )
                ],
              );
            }),
      ),
    ));
  }
}
