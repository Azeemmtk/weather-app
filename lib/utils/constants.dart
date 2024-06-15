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
                        : img = Image.asset(
                            'assets/images/clear night.png',
                            fit: BoxFit.fill,
                          );
    return img;
  }
}
