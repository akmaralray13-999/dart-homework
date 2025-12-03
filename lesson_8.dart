import 'rpg_game.dart';

void main() {
  RpgGame.startGame();
}

///////// Новый перс Лудоман //////////////
class Ludoman extends Hero {
  Ludoman(String name, int health, int damage)
    : super(name, health, damage, SuperAbility.CRITICAL_DAMAGE);

  @override
  void applySuperPower(Boss boss, List<Hero> heroes) {
    if (!isAlive()) return;

    ///////////////  Бросаем две кости ///////////////////
    int dice1 = RpgGame.random.nextInt(6) + 1;
    int dice2 = RpgGame.random.nextInt(6) + 1;

    print('Ludoman $name rolled: $dice1 and $dice2');

    if (dice1 == dice2) {
      ////////////  Если числа на кости равны то берет эту сумму из ХП босса ////////////////////
      int damageToBoss = dice1 * dice2;
      boss.health -= damageToBoss;
      boss.ensureNonNegativeHealth();
      print(
        'Ludoman $name removed $damageToBoss HP from Boss ${boss.name}. Boss HP: ${boss.health}',
      );
    } else {
      ///////////  Если не равные числа выпали то берет эту сумму из ХП рандом тиммейта /////////////////
      final candidates = heroes.where((h) => h.isAlive() && h != this).toList();
      if (candidates.isNotEmpty) {
        final target = candidates[RpgGame.random.nextInt(candidates.length)];
        int damageToAlly = dice1 + dice2;
        target.health -= damageToAlly;
        target.ensureNonNegativeHealth();
        print(
          'Ludoman $name punished ${target.name} for $damageToAlly HP. ${target.name} HP: ${target.health}',
        );
      }
    }
  }
}
