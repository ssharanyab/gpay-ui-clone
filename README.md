
# Google Pay UI Clone

Google pay payment UI Clone made with flutter .


## Features

- Edit Amount in real-time
- Enter-pin field can take values of varying length (4/6)
- Bloc pattern used for state management
- Custom Animations applied
- No external packages used


## Screenshots

![App Screenshot](https://raw.githubusercontent.com/ssharanyab/gpay-ui-clone/main/assets/screenshots/screen_recording_gif.gif)



|                       |                       |
| ----------------------------------- | ----------------------------------- |
| ![first_page](https://raw.githubusercontent.com/ssharanyab/gpay-ui-clone/main/assets/screenshots/first_page.png) | ![second_page_1](https://raw.githubusercontent.com/ssharanyab/gpay-ui-clone/main/assets/screenshots/second_page_1.png) |

|                       |                       |
| ----------------------------------- | ----------------------------------- |
| ![second_page_2](https://raw.githubusercontent.com/ssharanyab/gpay-ui-clone/main/assets/screenshots/second_page_2.png) | ![third_page](https://raw.githubusercontent.com/ssharanyab/gpay-ui-clone/main/assets/screenshots/third_page.png) |

## Dummy Data Used
- NOTE: Length of enter pin field varies based on this data

```dart
  final List<BankModel> bankList = [
    BankModel(
      bankName: 'Bank One',
      bankIcon: Icons.account_balance_wallet,
      bankAccountNumber: '12345678',
      pin: 3456,
    ),
    BankModel(
      bankName: 'Bank Two',
      bankIcon: Icons.savings,
      bankAccountNumber: '87654321',
      pin: 6789,
    ),
    BankModel(
      bankName: 'Bank Three',
      bankIcon: Icons.paid,
      bankAccountNumber: '24681357',
      pin: 123456,
    ),
  ];
```

