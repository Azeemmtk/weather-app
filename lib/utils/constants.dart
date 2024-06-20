import 'package:flutter/cupertino.dart';

String apikey = '9f6a3529cc42a96a2e7b63c53a182794';

Image CloudChange(String descript, int hour) {
  Image img;
  if (hour >= 6 && hour < 18) {
    descript == 'Clouds'
        ? img = Image.asset(
            'assets/images/cloud.png',
            fit: BoxFit.fill,
          )
        : descript == 'broken clouds'
            ? img = Image.asset(
                'assets/images/broken day.png',
                fit: BoxFit.fill,
              )
            : descript == 'overcast clouds'
                ? img = Image.asset(
                    'assets/images/cloud.png',
                    fit: BoxFit.fill,
                  )
                : descript == 'scattered clouds'
                    ? img = Image.asset(
                        'assets/images/scatterd.png',
                        fit: BoxFit.fill,
                      )
                    : descript == 'few clouds'
                        ? img = Image.asset(
                            'assets/images/cloud few.png',
                            fit: BoxFit.fill,
                          )
                        : descript == 'moderate rain'
                            ? img = Image.asset(
                                'assets/images/moderate rain.png',
                                fit: BoxFit.fill,
                              )
                            : descript == 'light rain'
                                ? img = Image.asset(
                                    'assets/images/light rain.png',
                                    fit: BoxFit.fill,
                                  )
                                : descript == 'heavy intensity rain'
                                    ? img = Image.asset(
                                        'assets/images/heavy intecity rain.png',
                                        fit: BoxFit.fill,
                                      )
                                    : descript == 'very heavy rain'
                                        ? img = Image.asset(
                                            'assets/images/very heavy rain.png',
                                            fit: BoxFit.fill,
                                          )
                                        : img = Image.asset(
                                            'assets/images/clear day.png',
                                            fit: BoxFit.fill,
                                          );
    return img;
  } else {
    descript == 'Clouds'
        ? img = Image.asset(
            'assets/images/cloud.png',
            fit: BoxFit.fill,
          )
        : descript == 'broken clouds'
            ? img = Image.asset(
                'assets/images/broken night.png',
                fit: BoxFit.fill,
              )
            : descript == 'overcast clouds'
                ? img = Image.asset(
                    'assets/images/cloud.png',
                    fit: BoxFit.fill,
                  )
                : descript == 'scattered clouds'
                    ? img = Image.asset(
                        'assets/images/scatterd night.png',
                        fit: BoxFit.fill,
                      )
                    : descript == 'few clouds'
                        ? img = Image.asset(
                            'assets/images/cloud few.png',
                            fit: BoxFit.fill,
                          )
                        : descript == 'moderate rain'
                            ? img = Image.asset(
                                'assets/images/moderate rain.png',
                                fit: BoxFit.fill,
                              )
                            : descript == 'light rain'
                                ? img = Image.asset(
                                    'assets/images/light rain.png',
                                    fit: BoxFit.fill,
                                  )
                                : descript == 'heavy intensity rain'
                                    ? img = Image.asset(
                                        'assets/images/heavy intecity rain.png',
                                        fit: BoxFit.fill,
                                      )
                                    : descript == 'very heavy rain'
                                        ? img = Image.asset(
                                            'assets/images/very heavy rain.png',
                                            fit: BoxFit.fill,
                                          )
                                        : img = Image.asset(
                                            'assets/images/clear night.png',
                                            fit: BoxFit.fill,
                                          );
    return img;
  }
}
