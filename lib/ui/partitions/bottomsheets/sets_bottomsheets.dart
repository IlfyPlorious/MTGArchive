import 'package:flutter/material.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/requestmodels/setsrequest.dart';

class SetsFiltersBottomSheet extends StatefulWidget {
  SetsFiltersBottomSheet({Key? key, SetsFilters? setsFilters})
      : setsFilters = setsFilters ?? SetsFilters(),
        super(key: key);

  final SetsFilters setsFilters;

  @override
  State<SetsFiltersBottomSheet> createState() => _SetsFiltersBottomSheetState();
}

class _SetsFiltersBottomSheetState extends State<SetsFiltersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.eggshell,
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    const Expanded(flex: 1, child: Text('Choose date:')),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: TextButton(
                            child: Text(widget.setsFilters.dateAsString),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1993),
                                  lastDate: DateTime(2050));
                              setState(() {
                                widget.setsFilters.releaseDate =
                                    pickedDate ?? DateTime.now();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text('Before'),
                            ),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Switch(
                                inactiveThumbColor: CustomColors.orange,
                                value: widget.setsFilters.afterFilterDate,
                                onChanged: (newStateValue) {
                                  setState(() {
                                    widget.setsFilters.afterFilterDate =
                                        !widget.setsFilters.afterFilterDate;
                                  });
                                },
                              ),
                            ),
                            const FittedBox(
                                fit: BoxFit.fitWidth, child: Text('After')),
                          ],
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    const Text('Online only:'),
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Yes'),
                          value: true,
                          groupValue: widget.setsFilters.onlineOnly,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.setsFilters.onlineOnly = value ?? true;
                            });
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: const Text('No'),
                          value: false,
                          groupValue: widget.setsFilters.onlineOnly,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.setsFilters.onlineOnly = value ?? false;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    const Text('Expansions: '),
                    DropdownButton<Expansions>(
                      underline: const SizedBox(),
                      alignment: AlignmentDirectional.center,
                      value: widget.setsFilters.expansions,
                      items: Expansions.values
                          .map((expansion) => DropdownMenuItem<Expansions>(
                              alignment: AlignmentDirectional.centerStart,
                              value: expansion,
                              child: Text(expansion.getApiKey() ??
                                  Expansions.any.name)))
                          .toList(),
                      onChanged: (Expansions? expansion) {
                        setState(() {
                          widget.setsFilters.expansions =
                              expansion ?? Expansions.any;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text('Apply filters'),
                      onPressed: () {
                        Navigator.pop(context, widget.setsFilters);
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Reset filters'),
                      onPressed: () {
                        Navigator.pop(context, SetsFilters());
                      },
                    )
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
