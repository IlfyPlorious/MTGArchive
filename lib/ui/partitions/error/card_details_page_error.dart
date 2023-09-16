part of 'package:playground/ui/details_page.dart';

class CardDetailsPageError extends StatelessWidget {
  const CardDetailsPageError(this.exception, {Key? key, required this.id})
      : super(key: key);

  final Exception exception;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((exception as ScryfallError).getErrorMessage(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 40, color: CustomColors.blackOlive)),
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                context.read<DetailsCubit>().fetchCardById(id);
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
