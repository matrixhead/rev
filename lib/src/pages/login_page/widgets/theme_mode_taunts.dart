import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev/src/common/bloc/app_bloc.dart';

class ThemeModeTaunts extends StatefulWidget {
  const ThemeModeTaunts({
    super.key,
  });

  @override
  State<ThemeModeTaunts> createState() => _ThemeModeTauntsState();
}

class _ThemeModeTauntsState extends State<ThemeModeTaunts> {
  String toDarkTaunt = getRandomString(toDarkTaunts);
  String toLightTaunt = getRandomString(toLightTaunts);
  @override
  Widget build(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light
        ? TextButton(
            onPressed: () {
              context
                  .read<AppBloc>()
                  .add(SetThemeMode(themeMode: ThemeMode.dark));
              toLightTaunt = getRandomString(toLightTaunts);
            },
            child: Text(toDarkTaunt))
        : TextButton(
            onPressed: () {
              context
                  .read<AppBloc>()
                  .add(SetThemeMode(themeMode: ThemeMode.light));
              toDarkTaunt = getRandomString(toDarkTaunts);
            },
            child: Text(toLightTaunt));
  }
}

const toDarkTaunts  = [
  'Lights bothering you yet?',
  'You afraid of darkness?',
  'Trying to blind us?',
  'Saving for solar panels?',
  'Love paying high bills?',
  'Forgot how switches work?',
  'Practicing for Broadway spotlight?',
  'Need the sun indoors?',
  'Planning a disco party?',
  'Do lights comfort you?',
  'Is this daylight savings?',
  'Your fingers broken, huh?',
  'Light your new pet?',
  'Roommates or lampmates now?',
  'Trying to tan indoors?',
  'Is this a lighthouse?',
  'You scared of ghosts?',
  'Do bulbs relax you?',
  'Practicing for an interrogation?',
  'Your shadow needs company?',
  'Need sunglasses inside now?',
  'Forgot electricity costs money?',
  "Think it's daytime forever?",
  'Are you photosynthesizing?',
  'Scared of the dark, huh?',
  'Do you own the sun?',
  'Does the switch offend you?',
  'Light addict, are you?',
  'Are switches beneath you?',
  'Is it always morning?',
  'Afraid vampires will visit?',
  'Should I call Edison?',
  'Want a sunroof installed?',
  'Practicing for movie sets?',
  'Is this your therapy?',
  'Switches confuse you much?',
  'Want a torch instead?',
  'Trying to attract bugs?',
  'Are we a stadium now?',
  'Think darkness is illegal?',
  'Waiting for a blackout?',
  'Are you scared of shadows?',
  'Is light your hobby?',
  "Can't find the switch, huh?",
  'Is this your aesthetic?',
  'Saving the light industry?',
  'Does darkness scare you?',
  'Should I draw a map?',
  'Are lights your personality?',
  'Think switches are cursed?',
  'Do you love global warming?',
  'Should I hire a switcher?',
  'Practicing for a spotlight moment?',
  'Do bulbs pay rent?',
  'Is the switch on strike?',
  'Do you fear the unknown?',
  'You allergic to darkness?',
  'Love living in a glow?',
  'Should we invite the sun?',
  'Afraid to be alone, huh?',
  'Want a permanent tan?',
  'Are you scared of night?',
  'Did the light offend you?',
  'Are you solar-powered?',
  'Practicing for a photo shoot?',
  'Love blinding your roommate?',
  "Can't handle dim moments?",
  'Do you worship light bulbs?',
  'Are you summoning moths?',
  'Forgot darkness exists, huh?',
  'Did you break the switch?',
  'Think this is a spotlight?',
  'Are lights your security blanket?',
  'Should I buy blackout curtains?',
  'Do you love fluorescents?',
  'Want me to call maintenance?',
  'Is it always high noon?',
  'Practicing for an interrogation room?',
  'Forgot the meaning of “off”?',
  'Are you keeping ghosts away?',
  'Are lights your best friends?',
  'Trying to outshine the sun?',
  'Need a tutorial on switches?',
  'Practicing for a light show?',
  'Do you hate darkness too?',
  'Want to blind yourself too?',
  'Is this your safe space?',
  'Is darkness your mortal enemy?',
  'Forgot light has an “off”?',
  'Think lights are eternal?',
  'Should I call a shaman?',
  'Are you lighting a shrine?',
  'Want to light up my life?',
  "Forgot we're not Vegas?",
  'Do you hate shadows too?',
  'Do you sleep under spotlights?',
  'Need a bedtime sunbeam?',
];

const toLightTaunts = [
  'Enjoying the dark vibes?',
  'Saving electricity for who?',
  'Lost the light switch?',
  'Living in a cave now?',
  'You nocturnal or something?',
  'Planning a blackout party?',
  "Can't afford light bulbs?",
  'Are shadows your thing?',
  'Practicing night vision, huh?',
  'Want me to stumble?',
  'Trying to summon bats?',
  'Is this a haunted house?',
  'Lights too mainstream for you?',
  'Is this your ambiance?',
  'Do you hate brightness?',
  'Need a flashlight guide?',
  'Are we in a dungeon?',
  'Is this the Stone Age?',
  'Do switches scare you?',
  'Love sitting in gloom?',
  'Is darkness comforting you?',
  'Is this a meditation zone?',
  'Trying to set the mood?',
  'Are you a shadow dweller?',
  'Should I buy candles?',
  'Are we conserving energy now?',
  'Love tripping over things?',
  'Did the bulb offend you?',
  'Practicing for the apocalypse?',
  'Are lights overrated now?',
  'Too lazy to switch on?',
  'Is darkness your aesthetic?',
  "Think you're a ninja?",
  'Are we in a bunker?',
  'Afraid of well-lit rooms?',
  'Is this a power outage?',
  'Forgot how switches work?',
  "Think we're in a movie?",
  'Do you prefer the void?',
  'Is this a sensory deprivation chamber?',
  'Are lights too expensive?',
  'Need help finding the switch?',
  'Is this a spooky experiment?',
  'You okay with darkness?',
  'Is the sun enough?',
  'Trying to scare yourself?',
  'Forgot where the switch is?',
  'Are you saving the planet?',
  'Is this your energy-saving mode?',
  'Do you love stubbed toes?',
  'Are you scared of light?',
  'Think darkness is romantic?',
  'Are we practicing minimalism?',
  'Trying to conserve electricity alone?',
  'Are shadows your friends?',
  'Want to live in darkness?',
  'Think darkness hides messes?',
  'Practicing for a horror movie?',
  'Too cool for lights now?',
  'Forgot what brightness feels like?',
  'Is this a bat cave?',
  'Is the switch cursed?',
  'Do you love bumping into things?',
  'Should I get a lantern?',
  'Is this your horror movie set?',
  'Do you fear lightbulbs?',
  'Is this your spooky vibe?',
  'Trying to save the grid?',
  "Think we're hiding from someone?",
  'Are we mole people now?',
  'Is darkness your comfort zone?',
  'Need me to guide you?',
  'Are lights too bright for you?',
  'Did the light offend you?',
  'Are we avoiding electricity?',
  'Is this a survival test?',
  'Think this is a blackout drill?',
  'Do you prefer shadow puppets?',
  'Is this the medieval era?',
  'Do you fear light switches?',
  'Forgot how to use electricity?',
  "Think you're in a ghost story?",
  'Are you part vampire?',
  'Want to light up the room?',
  'Need help finding the bulb?',
  "Think you're in a stealth game?",
  'Are we on a power strike?',
  'Do you hate illumination?',
  'Are you allergic to brightness?',
  'Think lights kill creativity?',
  'Are you hiding from reality?',
  'Think shadows are cozy?',
  'Are you one with the dark?',
  'Do you miss the sun already?',
  'Should I call an electrician?',
  'Are you embracing gloom?',
  'Think light disrupts your zen?',
  'Are you planning a séance?',
  'Do you prefer complete obscurity?',
  'Is this your dark retreat?',
];

String getRandomString(List<String> strings) {
  final random = Random();
  int index = random.nextInt(strings.length);
  return strings[index];
}
