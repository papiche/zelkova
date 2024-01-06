import 'dart:convert';
import 'dart:math';

import 'package:durt/durt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ginkgo/data/models/contact.dart';
import 'package:ginkgo/data/models/payment_state.dart';
import 'package:ginkgo/data/models/transaction.dart';
import 'package:ginkgo/data/models/transaction_type.dart';
import 'package:ginkgo/g1/g1_helper.dart';
import 'package:ginkgo/ui/logger.dart';

void main() {
  test('Test serialization and deserialization of UInt8List seeds', () {
    final Uint8List seed = generateUintSeed();
    final String sSeed = seedToString(seed);

    final Uint8List seedRestored = seedFromString(sSeed);
    expect(seed, equals(seedRestored));
    final CesiumWallet wallet = generateCesiumWallet(seed);
    final CesiumWallet walletRestored = generateCesiumWallet(seedRestored);
    expect(wallet.pubkey, equals(walletRestored.pubkey));
    expect(wallet.seed, equals(walletRestored.seed));
    expect(wallet.rootKey, equals(walletRestored.rootKey));
  });

  test('parse different networks/peers BMAS', () {
    expect(
        parseHost('BMAS g1.texu.es 7443'), equals('https://g1.texu.es:7443'));
    expect(
        parseHost('BMAS g1.duniter.org 443'), equals('https://g1.duniter.org'));
    expect(parseHost('BMAS g1.leprette.fr 443 /bma'),
        equals('https://g1.leprette.fr/bma'));
    expect(parseHost('BMAS g1-vijitatman.es 212.227.41.252 443'),
        equals('https://g1-vijitatman.es'));
    expect(
        parseHost(
            'BMAS monnaie-libre.ortie.org/bma/ 192.168.1.35 2a01:cb0d:5c2:fa00:21e:68ff:feab:389a 443'),
        equals('https://monnaie-libre.ortie.org/bma'));
  });

  test('parse different networks/peers GVA S', () {
    expect(parseHost('GVA S duniter.master.aya.autissier.net 443 gva'),
        equals('https://duniter.master.aya.autissier.net/gva'));
    expect(parseHost('GVA S g1-test-dev.pini.fr 443 gva'),
        equals('https://g1-test-dev.pini.fr/gva'));
  });

  test('validate pub keys', () {
    expect(validateKey('FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm'),
        equals(true));

    expect(validateKey('BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5'),
        equals(true));

    expect(validateKey('naU6XunXd1LSSfsHu3aNk8ZqgSosKQcvEQz8F2KaRAy'),
        equals(true));
  });

  const String baseKey = 'FRYyk57Pi456EJRu9vqVfSHLgmUfx4Qc3goS62a7dUSm';
  final String publicKeyWithChecksum = getFullPubKey(baseKey);
  final List<String> keys = <String>[baseKey, publicKeyWithChecksum];

  for (final String publicKey in keys) {
    group('Tests for publicKey: $publicKey', () {
      test('validate qr uri with amount', () {
        final String uriA = getQrUri(pubKey: publicKey, amount: '10');
        final PaymentState? payA = parseScannedUri(uriA);
        expect(payA!.amount, equals(10),
            reason: 'amount should be 10 in $uriA');
        expect(payA.contacts[0].pubKey, equals(publicKey));
      });

      test('validate qr uri without amount', () {
        final String uriB = getQrUri(pubKey: publicKey);
        final PaymentState? payB = parseScannedUri(uriB);
        expect(payB!.amount, equals(null));
        expect(payB.contacts[0].pubKey, equals(publicKey));
      });

      test('validate qr scanned', () {
        final PaymentState? payC = parseScannedUri(publicKey);
        expect(payC!.amount, equals(null));
        expect(payC.contacts[0].pubKey, equals(publicKey));
      });

      test('validate qr uri with decimal amount', () {
        final String uriD = getQrUri(pubKey: publicKey, amount: '10.10');
        final PaymentState? payD = parseScannedUri(uriD);
        expect(payD!.amount, equals(10.10));
        expect(payD.contacts[0].pubKey, equals(publicKey));
      });

      test('validate qr uri with localized decimal amount', () {
        final String uriE =
            getQrUri(pubKey: publicKey, amount: '10,10', locale: 'es');
        final PaymentState? payE = parseScannedUri(uriE);
        expect(payE!.amount, equals(10.10));
        expect(payE.contacts[0].pubKey, equals(publicKey));
      });

      test('validate custom june uri with amount', () {
        final String uriF = 'june://$publicKey?amount=100';
        final PaymentState? payF = parseScannedUri(uriF);
        expect(payF!.amount, equals(100));
        expect(payF.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with comment and amount', () {
        final String uriJ =
            'june://$publicKey?comment=GCHANGE:AYDI9JPOVIL9ZVG-PNCU&amount=100';
        final PaymentState? payJ = parseScannedUri(uriJ);
        expect(payJ!.comment, equals('GCHANGE:AYDI9JPOVIL9ZVG-PNCU'));
        expect(payJ.amount, equals(100));
        expect(payJ.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with amount and comment', () {
        final String uriK =
            'june://$publicKey?amount=10&comment=This Is my comment';
        final PaymentState? payK = parseScannedUri(uriK);
        expect(payK!.comment, equals('This Is my comment'));
        expect(payK.amount, equals(10));
        expect(payK.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with reordered comment and amount', () {
        final String uriL =
            'june://$publicKey?comment=This Is my comment&amount=10';
        final PaymentState? payL = parseScannedUri(uriL);
        expect(payL!.comment, equals('This Is my comment'));
        expect(payL.amount, equals(10));
        expect(payL.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with localized amount and comment', () {
        final String uriM =
            'june://$publicKey?comment=Mi comentario&amount=10,0';
        final PaymentState? payM = parseScannedUri(uriM);
        expect(payM!.comment, equals('Mi comentario'));
        expect(payM.amount, equals(10));
        expect(payM.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with comment only', () {
        final String uriN = 'june://$publicKey?comment=This Is my comment';
        final PaymentState? payN = parseScannedUri(uriN);
        expect(payN!.amount == null, equals(true));
        expect(payN.comment, equals('This Is my comment'));
        expect(payN.contacts[0].pubKey, equals(publicKey));
      });

      test('validate june uri with encoded uri', () {
        final String uriN =
            Uri.encodeFull('june://$publicKey?comment=This Is my comment');
        final PaymentState? payN = parseScannedUri(uriN);
        expect(payN!.amount == null, equals(true));
        expect(payN.comment, equals('This Is my comment'));
        expect(payN.contacts[0].pubKey, equals(publicKey));
      });

      test('Replace incorrect comment characters', () {
        final String uriN = Uri.encodeFull(
            'june://$publicKey?comment=This Is my comment,!%áéíóú');
        final PaymentState? payN = parseScannedUri(uriN);
        expect(payN!.amount == null, equals(true));
        expect(payN.comment, equals('This Is my comment !%     '));
        expect(payN.contacts[0].pubKey, equals(publicKey));
      });
    });
  }

  test('encrypt/decrypt of keys', () {
    const String pass = '1234';
    const String wrongPass = '1235';
    final Map<String, String> sample = <String, String>{
      'public': 'some public',
      'private': 'some private'
    };
    final Map<String, String> encSample =
        encryptJsonForExport(jsonEncode(sample), pass);
    final String encJson = encSample['key']!;
    expect(encJson.isNotEmpty, equals(true));

    final Map<String, dynamic> decrypted = decryptJsonForImport(encJson, pass);
    expect(decrypted['public'], equals('some public'));
    expect(decrypted['private'], equals('some private'));

    try {
      // test wrong pass
      decryptJsonForImport(encJson, wrongPass);
    } catch (e) {
      expect(e, isArgumentError);
    }
  });
  test('encrypt/decrypt of keys', () {
    final Random random = Random();
    for (int i = 0; i < 50; i++) {
      final String pass = _generateRandomPatternPassword(random);
      final String wrongPass = _generateRandomPatternPassword(random);

      final Uint8List seed = generateUintSeed();
      final CesiumWallet wallet = generateCesiumWallet(seed);

      final Map<String, String> sample = <String, String>{
        'pubKey': wallet.pubkey,
        'seed': seedToString(wallet.seed)
      };

      final Map<String, String> encSample =
          encryptJsonForExport(jsonEncode(sample), pass);
      final String encJson = encSample['key']!;
      expect(encJson.isNotEmpty, equals(true));

      final Map<String, dynamic> decrypted =
          decryptJsonForImport(encJson, pass);
      expect(decrypted['pubKey'], equals(sample['pubKey']));
      expect(decrypted['seed'], equals(sample['seed']));

      try {
        // test wrong pass
        decryptJsonForImport(encJson, wrongPass);
      } on ArgumentError catch (e) {
        expect(e, isArgumentError);
      } catch (e) {
        if (kDebugMode) {
          print(
              'encjson: $encJson and wrongPass: $wrongPass correct pass: $pass');
        }
        // rethrow;
      }
    }
  });

  test('toG1 converse', () {
    expect(toG1(1, true, 0), equals(1));
    expect(toG1(1, false, 1024), equals(1024));
  });

  test('Valid checksum', () {
    const String publicKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    final String checksum = pkChecksum(publicKey);
    expect(checksum, 'HCT');
  });

  test('Invalid checksum', () {
    const String publicKey = '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH';
    const String invalidChecksum = '123';
    final String checksum = pkChecksum(publicKey);
    expect(checksum, isNot(invalidChecksum));
  });

  final List<List<String>> testData = <List<String>>[
    <String>['EniaswqLCeWRJfz39VJRQwC6QDbAhkRHV9tn2fjhcrnc', '5i1'],
    <String>['BrgsSYK3xUzDyztGBHmxq69gfNxBfe2UKpxG21oZUBr5', 'Anr'],
    <String>['6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH', 'HCT'],
    <String>['78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8', '4VT'],
    <String>['ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY', '9bG'],
    <String>['EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG', 'BJH'],
  ];

  for (final List<String?> data in testData) {
    test('Checksum of ${data[0]}', () {
      expect(pkChecksum(data[0]!), equals(data[1]));
      expect(getFullPubKey('${data[0]!}:${data[1]!}'),
          equals('${data[0]!}:${data[1]!}'));
      expect(getFullPubKey(data[0]!), equals('${data[0]!}:${data[1]!}'));
    });

    test('Parse scanned qr is not null', () {
      final String pubKey = '${data[0]}:${data[1]}';
      expect(validateKey(data[0]!), true);
      expect(validateKey(pubKey), true);
      expect(parseScannedUri(pubKey), isNotNull);
    });
  }
  group('Multiple parse of keys', () {
    test('Parsing from a spreadsheet', () async {
      const String spreadsheetText =
          'Key1: EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG:BJH\nKey2: ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY';

      final List<Contact> result = parseMultipleKeys(spreadsheetText);
      expect(result, <Contact>[
        const Contact(
            pubKey: 'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG:BJH'),
        const Contact(pubKey: 'ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY')
      ]);
    });

    test('Extraction from an email or telegram text', () {
      const String emailText =
          'Hello, here are the keys: EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG, ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:9bG. Thanks!';
      final List<Contact> result = parseMultipleKeys(emailText);
      expect(result, <Contact>[
        const Contact(pubKey: 'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG'),
        const Contact(
            pubKey: 'ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:9bG')
      ]);
    });

    test('Extraction from a list separated by semicolons', () {
      const String listText =
          'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG; ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:BJH; 78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8:4VT';
      final List<Contact> result = parseMultipleKeys(listText);
      expect(result, <Contact>[
        const Contact(pubKey: 'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG'),
        const Contact(
            pubKey: 'ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:BJH'),
        const Contact(
            pubKey: '78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8:4VT')
      ]);
    });

    test('Extraction from a list separated by spaces', () {
      const String listText =
          'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG      ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:BJH       78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8:4VT';
      final List<Contact> result = parseMultipleKeys(listText);
      expect(result, <Contact>[
        const Contact(pubKey: 'EdWkzNABz7dPancFqW6JVLqv1wpGaQSxgWmMf1pmY7KG'),
        const Contact(
            pubKey: 'ARErWXr3bhKYh8FqX9axMXxxRPXMuoZW4s73P1zBHUTY:BJH'),
        const Contact(
            pubKey: '78ZwwgpgdH5uLZLbThUQH7LKwPgjMunYfLiCfUCySkM8:4VT')
      ]);
    });

    test('Extraction from a long multiline list', () {
      const String listText = '''
          8JBM2M9QV6SjFEp3Uh2HRmVpnRDc3dMntwQcjstBZNuX:5n3
      Ej392BiCtChxxXQM48MwZ2pYnL3dgSmZU86YyBFMeLkA:A3y
      8HPc6FefhzrihNZAA9vNQKRKKHETjD1HSeN6M872cf9E:Ccv
      GTk7bY9BFXPjvSzAMErg5njjw3LCUkxR37jmx6iUJ6a3:9vZ
      AFv1D5xA7FCdHCTA1bqfQ3PWvwEM16Gw67QJ37obGnsv:2nq
      GXwUZgSub7t1SYuANjefe7T1rmxBpLw7mNA2efVGjBrq:8cm
      GAmZUfTZE4woHvc9vJMsnPWSPgRsXw8Kendvt7ce3foY:HgD
      AjyGGAxzTP89vKf59VS5pyXVM6RCreVpk4EYaDUARQLn:DPX
      7b6JByc8HSKtZxbKape5ZSkXRwNy6ZKApisryevmrZMe:8YL
      HmBhbso1v5V3iwvey7VpuuAHFFLKuHW9UFMCLN5Xj4a2:28K
      AxTvKn6LwicCHPcKCjH6iuv9ue6ie5rjyJuLjc8uRjdy:9NB
      AwtndDuAYWM3Ud7JzgyLvVixkmjsmwipiq9w7vcgULaa:Y5J
      8noJ9tppsvTAVmEUQ2jfYFxx8J7nvMmKrjMWUT8VE8k5:3s6
      6xZZcjN5xacHNYPFuhKSb615ZszMjExbpJahwCjhWmnk:4pB
      B7evv57KqKUgpei2CU4UcPW8wDnTUEEEuanUGxE4BjFo:2gM
      HWbwUExEBmYtvW7KkUaacEs6d4Rs2EESgjz6QYF2x3SB:AmC
      DkKyByr6ctR469AsPogToYxWF7CW4XLdqbKRRyAZvGV1:6DW
      5oPBgGtNB6LAUV18b28rbuXa36mJYLFtwjf29L1yxus9:GRC
      3BZNPG8BeEnQrssH69KuqSkifjV7AA2g8m2DfYynfD5V:CNx
      8LPPfQvbQoMMBMtz2ukZhUWLijq8YbTrCn4QZzy1SVjy:BX8
      4T8CWT4X1dp28urHowHEt4YzRsgvrpdevAbsJbMuqzmU:6wS
      5CvpNKRjpL6ywK4yLomYYryB1B4dceR8YcADzN6WvHkf:BHL
      6BMDEGNB5tzkMmj34h2NsAZN1tzmLM1ZU8M8p4TuSj5Z:hwK
      cDkGNDXpZBSsSzYWraB3VeYpqswXDcUMnQCYFxddfXC:B5F
      3fDryMzjSAx9mskjK21VJMWj5AQNnbrmkBWyXwzbd9Ja:AgQ
      51dUkT4Jv8RhQJJEvMVYbpYQJpBFNbDTvwpxZqPaPjj1:2Xw
      3ov8FnPX7dSBCGnhASRSTshp5Q2vGDwDAyatzfg27XyL:8qA
      oV2ymKGEzA6VuZ7f3crkvNuCGg4XcktRTaSY1iaXgLe:8Tw
      CYbCqMHnyzwbYSLnWi1RVjyZv69DhL9TxqEq39nbeKB4:AeV
      3L6JKkpeRGj8QcvEnpBfydtfXXEQxTsu22nEifmvgEqT:5i4
      C9ZdFLk8TohnEyPjsb6fQEXevfRhziMtyHRrK9Z7z3uB:Cb9
      C4toysKKjN7isftoNZprxwPyvj9TR8vANf7z4b7TDKYS:8C8
      4he8PiQqnwwRkCHgpiYrN5HL6GWihY15PLUXmnbov45Y:2uc
      9GvC1LA548f5bs4wP6uFLAmKGfYc8KoUX63mzcUCY8kA:2mh
      FktChvTDsxC48zM79RzTpPY17aYezBURYyv7V84RYe4N:HEJ
      2h51fLtrS49ZvUgjfw8BkJJELsS9bvczSCncV9b61uBw:z4n
      9xKMPFbjEhHrgLK2Lzsxw2jvMiFvbiJ6dy1f1swTbw4R:7ir
      CYVY4642eXPNKMeFS1Ht1iAfKLJpu6Pg9b8HiQccv5iY:Gdv
      9GFgJDtZFiJEJzcxtN5EJkBRb4C1tdXifd9tYCSNEYq9:Gs2
      8wERYn5fWSnC4v7ahYyso7fJzDHv5nDa6SvfPQKLn8or:3A7
      BzoRjAExZ6beiMa6DeW8k2JaFEeuaiDZJEfoNk1sddaw
      2oPRopkCe8PMzCCVUcuabFMidQbnenkP94WHMaQejPcK
      3Jn5pFnP7XJwEefRD3pAS8ayRFbnKEaAdoEKJhPo5d3E:CDe
      mmYkG293mHQfjFa71wkBhnZ84vtgBsQUeJpbcQwsGcL:DKL
      J6n3SDGmtbDwsCznSwcDN7AtME2Ycc1HQtwAtCpEFNpT:Bnt
      66uRwVKV9SV29tzeLTnURqweBVGcyBkM4pYexXHLwT4R:2A8
      6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH:HCT
      CNuN2k2NrrX11u182pdX7Hxg6QVEzvKqn9Jq6vykt8Gs:Dxi
      Civz7VLoKakWW9iRk5QtbbziGQYHK8Xqv5FXu9tDbPq:F7v
      3akw6wCdsrauLgnMFQuJ2BoC7waB1ao3xovh7NRZLU1Y:Dn5
      7tH5qeBxsS15UMAf8Jh3FsGmpPkUJqBUBLwDgXyK3UTo:HVL
      CZAnpHKEFiqsUUqP3eMMeZkhKkhd1rEyQP2bdtJoLqTT:8yx''';
      final List<Contact> results = parseMultipleKeys(listText);
      expect(results.length, 52);
      final Map<Contact, int> contactCounts = <Contact, int>{};
      for (final Contact contact in results) {
        if (!contactCounts.containsKey(contact)) {
          contactCounts[contact] = 1;
        } else {
          contactCounts[contact] = contactCounts[contact]! + 1;
        }
      }

      final List<Contact> duplicates = contactCounts.entries
          .where((MapEntry<Contact, int> entry) => entry.value > 1)
          .map((MapEntry<Contact, int> entry) => entry.key)
          .toList();

      logger('Duplicated: $duplicates');
      expect(Set<Contact>.from(results).length, 52);
    });
  });

  const Contact from = Contact(pubKey: 'from-publicKey');
  const Contact to1 = Contact(pubKey: 'to-publicKey-1');
  const Contact to2 = Contact(pubKey: 'to-publicKey-2');
  const Contact to3 = Contact(pubKey: 'to-publicKey-3');
  const Contact to4 = Contact(pubKey: 'to-publicKey-4');

  test('genTxKey single recipient', () {
    final Transaction transaction = Transaction(
      to: to1,
      amount: 10.0,
      comment: 'Test transaction',
      type: TransactionType.pending,
      time: DateTime.now(),
      from: from,
    );

    final String result = genTxKey(transaction);

    expect(result,
        equals('from:from-publicKey-to:to-publicKey-1-Test transaction-10.0'));
  });

  test('genTxKey multiple recipients', () {
    final Transaction transaction = Transaction(
      from: from,
      to: to1,
      type: TransactionType.sending,
      time: DateTime.now(),
      recipients: const <Contact>[to1, to2, to3, to4],
      amount: 10.0,
      comment: 'Test transaction',
    );

    final String result = genTxKey(transaction);

    expect(
        result,
        equals(
            'from:from-publicKey-to:to-publicKey-1-to-publicKey-2-to-publicKey-3-to-publicKey-4-Test transaction-10.0'));
  });

  test('genTxKey for sending and pending transactions', () {
    //{"type":"sending","from":{"nick":null,"pubKey":"2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf","avatar":[],"notes":null,"name":null},"to":{"nick":null,"pubKey":"2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf","avatar":[],"notes":null,"name":null},"amount":-20.0,"comment":"m 6:11","time":"2023-12-23T06:13:16.773769","debugInfo":null,"recipients":[{"nick":null,"pubKey":"2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf","avatar":[],"notes":null,"name":null},{"nick":null,"pubKey":"HQvpc5EVTGxjWBF7zsUQR9qgAba3Mn2vNivCLphLQVpS","avatar":[],"notes":null,"name":null},{"nick":null,"pubKey":"A23W3Z4NNxShFThCwHsru1pgzMJDMSf5GaJxb3A5ipih","avatar":[],"notes":null,"name":null}],"recipientsAmounts":[0.0,0.0,10.0]}
    //{"type":"pending","from":{"nick":null,"pubKey":"2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf","avatar":[],"notes":null,"name":null},"to":{"nick":null,"pubKey":"HQvpc5EVTGxjWBF7zsUQR9qgAba3Mn2vNivCLphLQVpS","avatar":[],"notes":null,"name":"vjrj chrome"},"amount":-20.0,"comment":"m 6:11","time":"2023-12-23T06:11:18.0652
    const String sendingTransactionJson = '''
{
  "type": "sending",
  "from": {
    "nick": null,
    "pubKey": "2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf",
    "avatar": [],
    "notes": null,
    "name": null
  },
  "to": {
    "nick": null,
    "pubKey": "2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf",
    "avatar": [],
    "notes": null,
    "name": null
  },
  "amount": -20.0,
  "comment": "m 6:11",
  "time": "2023-12-23T06:13:16.773769",
  "debugInfo": null,
  "recipients": [
    {
      "nick": null,
      "pubKey": "2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf",
      "avatar": [],
      "notes": null,
      "name": null
    },
    {
      "nick": null,
      "pubKey": "HQvpc5EVTGxjWBF7zsUQR9qgAba3Mn2vNivCLphLQVpS",
      "avatar": [],
      "notes": null,
      "name": null
    },
    {
      "nick": null,
      "pubKey": "A23W3Z4NNxShFThCwHsru1pgzMJDMSf5GaJxb3A5ipih",
      "avatar": [],
      "notes": null,
      "name": null
    }
  ],
  "recipientsAmounts": [0.0, 0.0, 10.0]
}
''';

    const String pendingTransactionJson = '''
{
  "type": "pending",
  "from": {
    "nick": null,
    "pubKey": "2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf",
    "avatar": [],
    "notes": null,
    "name": null
  },
  "to": {
    "nick": null,
    "pubKey": "HQvpc5EVTGxjWBF7zsUQR9qgAba3Mn2vNivCLphLQVpS",
    "avatar": [],
    "notes": null,
    "name": "vjrj chrome"
  },
  "amount": -20.0,
  "comment": "m 6:11",
  "time": "2023-12-23T06:11:18.0652",
  "recipients": [
    {
      "nick": null,
      "pubKey": "2AD8Eg55RKidFLcFBVy8NuSrNsPvwrDjPe2SLq8seMjf",
      "avatar": [],
      "notes": null,
      "name": null
    },
    {
      "nick": null,
      "pubKey": "HQvpc5EVTGxjWBF7zsUQR9qgAba3Mn2vNivCLphLQVpS",
      "avatar": [],
      "notes": null,
      "name": null
    },
    {
      "nick": null,
      "pubKey": "A23W3Z4NNxShFThCwHsru1pgzMJDMSf5GaJxb3A5ipih",
      "avatar": [],
      "notes": null,
      "name": null
    }
  ],
  "recipientsAmounts": [0.0, 0.0, 10.0]
}
''';

    final Map<String, dynamic> sendingTransactionMap =
        jsonDecode(sendingTransactionJson) as Map<String, dynamic>;
    final Transaction sendingTransaction =
        Transaction.fromJson(sendingTransactionMap);

    final Map<String, dynamic> pendingTransactionMap =
        jsonDecode(pendingTransactionJson) as Map<String, dynamic>;
    final Transaction pendingTransaction =
        Transaction.fromJson(pendingTransactionMap);

    final String sendingId = genTxKey(sendingTransaction);
    final String pendingId = genTxKey(pendingTransaction);

    expect(sendingId, equals(pendingId));
  });

  test('Transaction serialization includes recipients and recipientsAmounts',
      () {
    final Transaction transaction = Transaction(
      type: TransactionType.sending,
      from: const Contact(pubKey: 'from-publicKey'),
      to: const Contact(pubKey: 'to-publicKey-1'),
      recipients: const <Contact>[
        Contact(pubKey: 'to-publicKey-1'),
        Contact(pubKey: 'to-publicKey-2'),
        Contact(pubKey: 'to-publicKey-3'),
      ],
      recipientsAmounts: const <double>[10.0, 20.0, 30.0],
      amount: 60.0,
      comment: 'Test transaction',
      time: DateTime.now(),
    );

    final Map<String, dynamic> json = transaction.toJson();

    expect(json['recipients'], isNotNull);
    expect(json['recipientsAmounts'], isNotNull);

    final List<Contact> recipientsJson =
        List<Contact>.from(json['recipients'] as List<Contact>);
    final List<double> recipientsAmountsJson =
        List<double>.from(json['recipientsAmounts'] as List<double>);

    expect(recipientsJson.length, equals(3));
    expect(recipientsAmountsJson.length, equals(3));

    expect(recipientsJson[0].pubKey, equals('to-publicKey-1'));
    expect(recipientsJson[1].pubKey, equals('to-publicKey-2'));
    expect(recipientsJson[2].pubKey, equals('to-publicKey-3'));

    expect(recipientsAmountsJson[0], equals(10.0));
    expect(recipientsAmountsJson[1], equals(20.0));
    expect(recipientsAmountsJson[2], equals(30.0));
  });

  test(
      'Copy of sending transaction to pending maintains recipients and recipientsAmounts',
      () {
    final Transaction sendingTransaction = Transaction(
      type: TransactionType.sending,
      from: const Contact(pubKey: 'from-publicKey'),
      to: const Contact(pubKey: 'to-publicKey-1'),
      recipients: const <Contact>[
        Contact(pubKey: 'to-publicKey-1'),
        Contact(pubKey: 'to-publicKey-2'),
        Contact(pubKey: 'to-publicKey-3'),
      ],
      recipientsAmounts: const <double>[10.0, 20.0, 30.0],
      amount: 60.0,
      comment: 'Test transaction',
      time: DateTime.now(),
    );

    final Transaction pendingTransaction =
        sendingTransaction.copyWith(type: TransactionType.pending);

    expect(
        pendingTransaction.recipients, equals(sendingTransaction.recipients));
    expect(pendingTransaction.recipientsAmounts,
        equals(sendingTransaction.recipientsAmounts));
  });
}

String _generateRandomPatternPassword(Random random) {
  final int length = random.nextInt(8) + 2; // Password length between 2 and 9.
  final Set<int> digits = <int>{1, 2, 3, 4, 5, 6, 7, 8, 9};
  final List<int> passwordDigits = <int>[];
  for (int i = 0; i < length; i++) {
    final int selectedDigit = digits.elementAt(random.nextInt(digits.length));
    passwordDigits.add(selectedDigit);
    digits.remove(selectedDigit);
  }
  return passwordDigits.join();
}
