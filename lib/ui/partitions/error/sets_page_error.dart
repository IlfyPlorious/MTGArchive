part of 'package:playground/ui/cards_page.dart';

class SetsPageError extends StatelessWidget {
  SetsPageError(this.exception, {Key? key, SetsRequest? request}) : request = request ?? SetsRequest(), super(key: key);

  final Exception exception;
  final SetsRequest request;

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
                context.read<SetsPageCubit>().fetchSets(request);
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
