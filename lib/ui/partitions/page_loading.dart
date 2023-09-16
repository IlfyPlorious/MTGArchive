part of 'package:playground/ui/cards_page.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50.0,
        height: 50.0,
        child: LoadingIndicator(
            indicatorType: Indicator.cubeTransition,
            colors: [CustomColors.orange, CustomColors.blackOlive]),
      ),
    );
  }
}
