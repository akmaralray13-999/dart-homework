import 'dart:math';

void main() {
  RpgGame.start();
}

enum SuperAbility {
  CRITICAL_DAMAGE,
  BOOST,
  HEAL,
  BLOCK_DAMAGE_AND_REVERT,
  TAKE_DAMAGE,
  DODGE,
  RESURRECT,
  STUN,
}

abstract class GameCharacter {
  String name;
  int health;
  int damage;
  GameCharacter(this.name, this.health, this.damage);
  bool isAlive() => health > 0;
  void ensureNonNegativeHealth() {
    if (health < 0) health = 0;
  }
}

class Boss extends GameCharacter {
  bool isStunned = false;
  Boss(String name, int health, int damage) : super(name, health, damage);
  void attack(List<Hero> heroes) {
    if (!isAlive()) return;
    Golem? golem = heroes.whereType<Golem>().firstWhere(
      (g) => g.isAlive(),
      orElse: () => null,
    );
    for (final hero in heroes) {
      if (!hero.isAlive()) continue;
      if (hero is Lucky) {
        final dodged = RpgGame.random.nextInt(100) < 25;
        if (dodged) {
          print('Lucky ${hero.name} dodged the attack!');
          continue;
        }
      }
      int incoming = damage;
      int redirected = 0;
      if (golem != null && golem.isAlive() && hero != golem) {
        redirected = incoming ~/ 5;
        golem.health -= redirected;
        golem.ensureNonNegativeHealth();
        print('Golem ${golem.name} absorbs $redirected damage intended for ${hero.name}. Golem HP: ${golem.health}');
        if (!golem.isAlive()) {
          print('Golem ${golem.name} has fallen. Protection ends.');
          golem = null;
        }
      }
      int finalDamage = incoming - redirected;
      hero.health -= finalDamage;
      hero.ensureNonNegativeHealth();
      print('Boss ${name} hits ${hero.name} for $finalDamage. ${hero.name} HP: ${hero.health}');
      if (!hero.isAlive()) {
        print('${hero.name} has been defeated.');
      }
    }
  }
}

abstract class Hero extends GameCharacter {
  SuperAbility ability;
  Hero(String name, int health, int damage, this.ability) : super(name, health, damage);
  void attack(Boss boss) {
    if (!isAlive() || !boss.isAlive()) return;
    boss.health -= damage;
    boss.ensureNonNegativeHealth();
    print('${runtimeType} $name hits Boss ${boss.name} for $damage. Boss HP: ${boss.health}');
  }
  void applySuperPower(Boss boss, List<Hero> heroes);
}

class Magic extends Hero {
  Magic(String name, int health, int damage) : super(name, health, damage, SuperAbility.BOOST);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive()) return;
    if (RpgGame.roundNumber <= 4) {
      for (final h in heroes) {
        if (!h.isAlive()) continue;
        if (identical(h, this)) continue;
        final boost = 3 + RpgGame.random.nextInt(6);
        h.damage += boost;
        print('Magic $name boosts ${h.name} by +$boost damage (now ${h.damage}).');
      }
    }
  }
}

class Golem extends Hero {
  Golem(String name, int health, int damage) : super(name, health, damage, SuperAbility.TAKE_DAMAGE);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {}
}

class Lucky extends Hero {
  Lucky(String name, int health, int damage) : super(name, health, damage, SuperAbility.DODGE);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {}
}

class Witcher extends Hero {
  bool hasResurrected = false;
  Witcher(String name, int health) : super(name, health, 0, SuperAbility.RESURRECT);
  @override
  void attack(Boss boss) {
    if (!isAlive()) return;
    print('Witcher $name does not attack the boss.');
  }
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive()) return;
    if (hasResurrected) return;
    final deadHero = heroes.firstWhere((h) => !h.isAlive(), orElse: () => null);
    if (deadHero != null) {
      deadHero.health = this.health;
      this.health = 0;
      hasResurrected = true;
      print('Witcher $name sacrificed himself to resurrect ${deadHero.name} with ${deadHero.health} HP.');
    }
  }
}

class Thor extends Hero {
  Thor(String name, int health, int damage) : super(name, health, damage, SuperAbility.STUN);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive()) return;
    if (RpgGame.random.nextBool()) {
      boss.isStunned = true;
      print('Thor $name stunned the boss!');
    }
  }
}

class Warrior extends Hero {
  Warrior(String name, int health, int damage) : super(name, health, damage, SuperAbility.CRITICAL_DAMAGE);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive() || !boss.isAlive()) return;
    if (RpgGame.random.nextInt(100) < 30) {
      int crit = (damage * 1.5).round();
      boss.health -= crit;
      boss.ensureNonNegativeHealth();
      print('Warrior $name lands a CRITICAL for $crit! Boss HP: ${boss.health}');
    }
  }
}

class Berserk extends Hero {
  int blockedLastRound = 0;
  Berserk(String name, int health, int damage) : super(name, health, damage, SuperAbility.BLOCK_DAMAGE_AND_REVERT);
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive() || !boss.isAlive()) return;
    if (blockedLastRound > 0) {
      boss.health -= blockedLastRound;
      boss.ensureNonNegativeHealth();
      print('Berserk $name reflects $blockedLastRound back to Boss. Boss HP: ${boss.health}');
      blockedLastRound = 0;
    }
  }
}

class Medic extends Hero {
  int healPower;
  Medic(String name, int health, int damage, this.healPower) : super(name, health, damage, SuperAbility.HEAL);
  @override
  void attack(Boss boss) {
    if (!isAlive()) return;
    if (damage > 0) {
      boss.health -= damage;
      boss.ensureNonNegativeHealth();
      print('Medic $name deals $damage. Boss HP: ${boss.health}');
    } else {
      print('Medic $name focuses on healing and skips attack.');
    }
  }
  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive()) return;
    final candidates = heroes.where((h) => h.isAlive() && h != this).toList();
    if (candidates.isEmpty) return;
    final target = candidates[RpgGame.random.nextInt(candidates.length)];
    target.health += healPower;
    print('Medic $name heals ${target.name} by $healPower. ${target.name} HP: ${target.health}');
  }
}

class RpgGame {
  static final Random random = Random();
  static int roundNumber = 0;
  static void start() {
    final boss = Boss('Dreadlord', 1000, 70);
    final heroes = <Hero>[
      Warrior('Arthas', 270, 30),
      Berserk('Ragnar', 260, 35),
      Magic('Merlin', 240, 0),
      Medic('Ana', 230, 0, 30),
      Golem('Boulder', 420, 20),
      Lucky('Fortuna', 250, 28),
      Witcher('Vesemir', 220),
      Thor('Odinson', 280, 32),
    ];
    print('=== RPG Game Start ===');
    _printStatus(boss, heroes);
    while (boss.isAlive() && heroes.any((h) => h.isAlive())) {
      _playRound(boss, heroes);
    }
    if (boss.isAlive()) {
      print('Boss ${boss.name} wins. Heroes have fallen.');
    } else {
      print('Heroes are victorious! Boss ${boss.name} has been defeated.');
    }
  }
  static void _playRound(Boss boss, List<Hero> heroes) {
    roundNumber++;
    print('\n--- Round $roundNumber ---');
    if (boss.isStunned) {
      print('Boss ${boss.name} is stunned and skips the attack!');
      boss.isStunned = false;
    } else {
      boss.attack(heroes);
      final berserk = heroes.whereType<Berserk>().firstWhere(
        (b) => b.isAlive(),
        orElse: () => null,
      );
      if (berserk != null) {
        berserk.blockedLastRound = 15;
        print('Berserk ${berserk.name} blocks 15 damage to reflect next.');
      }
   