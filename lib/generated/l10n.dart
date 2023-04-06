// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Player`
  String get Joueur {
    return Intl.message(
      'Player',
      name: 'Joueur',
      desc: '',
      args: [],
    );
  }

  /// `Players`
  String get Joueurs {
    return Intl.message(
      'Players',
      name: 'Joueurs',
      desc: '',
      args: [],
    );
  }

  /// `Add player`
  String get AjouterJoueur {
    return Intl.message(
      'Add player',
      name: 'AjouterJoueur',
      desc: '',
      args: [],
    );
  }

  /// `game`
  String get partie {
    return Intl.message(
      'game',
      name: 'partie',
      desc: '',
      args: [],
    );
  }

  /// `Add Scores`
  String get AjoutScores {
    return Intl.message(
      'Add Scores',
      name: 'AjoutScores',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get Score {
    return Intl.message(
      'Score',
      name: 'Score',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Annuler {
    return Intl.message(
      'Cancel',
      name: 'Annuler',
      desc: '',
      args: [],
    );
  }

  /// `Validate`
  String get Valider {
    return Intl.message(
      'Validate',
      name: 'Valider',
      desc: '',
      args: [],
    );
  }

  /// `Scoreboard`
  String get TableauScores {
    return Intl.message(
      'Scoreboard',
      name: 'TableauScores',
      desc: '',
      args: [],
    );
  }

  /// `Editing`
  String get Edition {
    return Intl.message(
      'Editing',
      name: 'Edition',
      desc: '',
      args: [],
    );
  }

  /// `Edit Last Run`
  String get ModifierDmanche {
    return Intl.message(
      'Edit Last Run',
      name: 'ModifierDmanche',
      desc: '',
      args: [],
    );
  }

  /// `Delete last run`
  String get SuppDmanche {
    return Intl.message(
      'Delete last run',
      name: 'SuppDmanche',
      desc: '',
      args: [],
    );
  }

  /// `Game history`
  String get Historic {
    return Intl.message(
      'Game history',
      name: 'Historic',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get supprimer {
    return Intl.message(
      'delete',
      name: 'supprimer',
      desc: '',
      args: [],
    );
  }

  /// `reset score at 0`
  String get ScoreA0 {
    return Intl.message(
      'reset score at 0',
      name: 'ScoreA0',
      desc: '',
      args: [],
    );
  }

  /// `Scores will be reset`
  String get ScoreVAa0 {
    return Intl.message(
      'Scores will be reset',
      name: 'ScoreVAa0',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get Statistiques {
    return Intl.message(
      'Statistics',
      name: 'Statistiques',
      desc: '',
      args: [],
    );
  }

  /// `Evolution of scores`
  String get EvolutionScores {
    return Intl.message(
      'Evolution of scores',
      name: 'EvolutionScores',
      desc: '',
      args: [],
    );
  }

  /// `Percentage of total score`
  String get Pourcentage {
    return Intl.message(
      'Percentage of total score',
      name: 'Pourcentage',
      desc: '',
      args: [],
    );
  }

  /// `Average score :`
  String get ScoreMoyen {
    return Intl.message(
      'Average score :',
      name: 'ScoreMoyen',
      desc: '',
      args: [],
    );
  }

  /// `Average Position :`
  String get PositionMoyenne {
    return Intl.message(
      'Average Position :',
      name: 'PositionMoyenne',
      desc: '',
      args: [],
    );
  }

  /// `Worst score :`
  String get PireScore {
    return Intl.message(
      'Worst score :',
      name: 'PireScore',
      desc: '',
      args: [],
    );
  }

  /// `Number of Dutch :`
  String get NombreDutchs {
    return Intl.message(
      'Number of Dutch :',
      name: 'NombreDutchs',
      desc: '',
      args: [],
    );
  }

  /// `Dutch won :`
  String get DutchsGagnes {
    return Intl.message(
      'Dutch won :',
      name: 'DutchsGagnes',
      desc: '',
      args: [],
    );
  }

  /// `Dutch rates :`
  String get TauxDutchs {
    return Intl.message(
      'Dutch rates :',
      name: 'TauxDutchs',
      desc: '',
      args: [],
    );
  }

  /// `Stolen Dutchs :`
  String get DutchsVoles {
    return Intl.message(
      'Stolen Dutchs :',
      name: 'DutchsVoles',
      desc: '',
      args: [],
    );
  }

  /// `Worst ennemy :`
  String get PireEnnemi {
    return Intl.message(
      'Worst ennemy :',
      name: 'PireEnnemi',
      desc: '',
      args: [],
    );
  }

  /// `stole`
  String get aVole {
    return Intl.message(
      'stole',
      name: 'aVole',
      desc: '',
      args: [],
    );
  }

  /// `dutch`
  String get dutchs {
    return Intl.message(
      'dutch',
      name: 'dutchs',
      desc: '',
      args: [],
    );
  }

  /// `pts :`
  String get points {
    return Intl.message(
      'pts :',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your Score Dutch account`
  String get Connexion {
    return Intl.message(
      'Log in to your Score Dutch account',
      name: 'Connexion',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get Email {
    return Intl.message(
      'E-mail',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Mdp {
    return Intl.message(
      'Password',
      name: 'Mdp',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password ?`
  String get MdpOublie {
    return Intl.message(
      'Forgot your password ?',
      name: 'MdpOublie',
      desc: '',
      args: [],
    );
  }

  /// `To log in`
  String get SeConnecter {
    return Intl.message(
      'To log in',
      name: 'SeConnecter',
      desc: '',
      args: [],
    );
  }

  /// `Register with`
  String get EnregistrezVous {
    return Intl.message(
      'Register with',
      name: 'EnregistrezVous',
      desc: '',
      args: [],
    );
  }

  /// `Not registered ?`
  String get PasDeCompte {
    return Intl.message(
      'Not registered ?',
      name: 'PasDeCompte',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get CreerUnCompte {
    return Intl.message(
      'Create an account',
      name: 'CreerUnCompte',
      desc: '',
      args: [],
    );
  }

  /// `confirmation password`
  String get confirmation {
    return Intl.message(
      'confirmation password',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreerCompte {
    return Intl.message(
      'Create Account',
      name: 'CreerCompte',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get EntrezEmailValide {
    return Intl.message(
      'Enter a valid email',
      name: 'EntrezEmailValide',
      desc: '',
      args: [],
    );
  }

  /// `Password of at least 6 characters`
  String get Mdp6car {
    return Intl.message(
      'Password of at least 6 characters',
      name: 'Mdp6car',
      desc: '',
      args: [],
    );
  }

  /// `Players have the same name`
  String get MemeNom {
    return Intl.message(
      'Players have the same name',
      name: 'MemeNom',
      desc: '',
      args: [],
    );
  }

  /// `has no name`
  String get pasDeNom {
    return Intl.message(
      'has no name',
      name: 'pasDeNom',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr', countryCode: 'FR'),
      Locale.fromSubtags(languageCode: 'hi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
