part of 'package:playground/ui/cards_page.dart';

class BackHeader extends StatelessWidget {
  const BackHeader({Key? key, this.headerTitle = ''}) : super(key: key);

  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.blackOlive,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 20,
            width: 20,
            margin: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              iconSize: 20,
              padding: const EdgeInsets.all(0),
              icon: Image.asset('assets/images/back_arrow_light.png'),
            ),
          ),
          Text(
            headerTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: CustomColors.gray, fontSize: 20),
          ),
          const SizedBox(width: 50)
        ],
      ),
    );
  }
}
