import 'package:bmi_calculator/result_page.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/body_model.dart';
import 'package:bmi_calculator/palette.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  // Use this Body Model as default
  BodyModel model = BodyModel(
    sex: Sex.male,
    height: 183,
    weight: 74,
    age: 19,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Palette.background,
        ),
        body: Container(
          color: Palette.background,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.width - 48) / 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Set sex to male
                            setState(() {
                              model.sex = Sex.male;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: model.sex == Sex.male
                                  ? Palette.cardBackgroundActive
                                  : Palette.cardBackgroundInactive,
                            ),
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.male_rounded,
                                  size: 100,
                                  color: model.sex == Sex.male
                                      ? Palette.textActive
                                      : Palette.textInactive,
                                ),
                                Text(
                                  'MALE',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: model.sex == Sex.male
                                        ? Palette.textActive
                                        : Palette.textInactive,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Set sex to female
                            setState(() {
                              model.sex = Sex.female;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: model.sex == Sex.female
                                  ? Palette.cardBackgroundActive
                                  : Palette.cardBackgroundInactive,
                            ),
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.female_rounded,
                                  size: 100,
                                  color: model.sex == Sex.female
                                      ? Palette.textActive
                                      : Palette.textInactive,
                                ),
                                Text(
                                  'FEMALE',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600,
                                    color: model.sex == Sex.female
                                        ? Palette.textActive
                                        : Palette.textInactive,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.width - 48) / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Palette.cardBackgroundInactive,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'HEIGHT',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Palette.textInactive,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            model.height.round().toString(),
                            style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w800,
                              color: Palette.textActive,
                            ),
                          ),
                          const Text(
                            'cm',
                            style: TextStyle(
                              fontSize: 30,
                              color: Palette.textInactive,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 1.0,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 15,
                            ),
                          ),
                          child: Slider(
                            value: model.height.toDouble(),
                            min: 150.0,
                            max: 210.0,
                            activeColor: Palette.textActive,
                            inactiveColor: Palette.textInactive,
                            thumbColor: Palette.action,
                            onChanged: (value) {
                              // Set height and round to Int
                              setState(() {
                                model.height = value.toInt();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: (MediaQuery.of(context).size.width - 48) / 2,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Palette.cardBackgroundInactive,
                          ),
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'WEIGHT',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textInactive,
                                ),
                              ),
                              Text(
                                model.weight.toString(),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.textActive,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Decrease weight
                                      setState(() {
                                        model.weight--;
                                      });
                                    },
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Palette.cardBackgroundActive,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Palette.textActive,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Increase weight
                                      setState(() {
                                        model.weight++;
                                      });
                                    },
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Palette.cardBackgroundActive,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Palette.textActive,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Palette.cardBackgroundInactive,
                          ),
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'AGE',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.textInactive,
                                ),
                              ),
                              Text(
                                model.age.toString(),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.textActive,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // Decrease age
                                      setState(() {
                                        model.age--;
                                      });
                                    },
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Palette.cardBackgroundActive,
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Palette.textActive,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Increase weight
                                      setState(() {
                                        model.age++;
                                      });
                                    },
                                    child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Palette.cardBackgroundActive,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: Palette.textActive,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Palette.action,
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.white.withOpacity(0.10)),
                    ),
                    child: const Text(
                      'CALCULATE YOUR BMI',
                      style: TextStyle(
                        color: Palette.textActive,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to Result Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => ResultPage(model: model)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
