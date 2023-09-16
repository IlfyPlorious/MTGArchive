part of 'package:playground/ui/cards_page.dart';

class CardsPageError extends StatelessWidget {
  CardsPageError(this.exception, {Key? key, CardsRequest? request})
      : request = request ?? CardsRequest(),
        super(key: key);

  final Exception exception;
  final CardsRequest request;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((exception as ServerErrorException).getServerError(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40, color: CustomColors.blackOlive)),
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                context.read<CardsListCubit>().fetchCards(request);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.blackOlive,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8)),
              child: const Text(
                'Retry',
                style: TextStyle(color: CustomColors.orange, fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
