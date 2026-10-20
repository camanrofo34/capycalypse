# 🦫 Capycalypse

[![Godot Engine](https://img.shields.io/badge/Godot%20Engine-4.7%2B-blue?logo=godotengine&logoColor=white)](https://godotengine.org/)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey)]()
[![Genre](https://img.shields.io/badge/Genre-2D%20Roguelite%20%2F%20Survivor-orange)]()
[![Physics](https://img.shields.io/badge/Physics-Jolt%20Physics%202D-green)]()
[![Renderer](https://img.shields.io/badge/Renderer-Forward%2B%20(D3D12%2FVulkan)-purple)]()

> **Capycalypse** is a fast-paced 2D roguelite horde survival / bullet heaven game developed in **Godot 4.7+**. Face ever-growing waves of fantastical creatures, build devastating weapon and passive item synergies, crack open destructible containers, and acquire permanent stat upgrades through a gold-based meta-progression skill tree.

---

## 📑 Table of Contents

- [🎮 Gameplay Overview](#-gameplay-overview)
- [🕹️ Controls](#️-controls)
- [👥 Playable Characters](#-playable-characters)
- [⚔️ Weapons & Evolution Synergies](#️-weapons--evolution-synergies)
- [🛡️ Passive Items](#️-passive-items)
- [👾 Bestiary & Wave Mechanics](#-bestiary--wave-mechanics)
- [💎 Pickups & Destructibles](#-pickups--destructibles)
- [🌟 Meta-Progression & Save System](#-meta-progression--save-system)
- [📁 Project Folder Organization](#-project-folder-organization)
- [⚙️ Technical Specifications](#️-technical-specifications)
- [🚀 Getting Started & Development](#-getting-started--development)

---

## 🎮 Gameplay Overview

In **Capycalypse**, the player selects a character and enters a perilous wilderness where enemy hordes spawn continuously around them:
- **Auto-Attacking Arsenal**: Weapons activate automatically on cooldown timers, targeting the closest enemies or orbiting the player.
- **Experience & Leveling**: Defeated enemies drop XP Gems. Collecting enough gems triggers a level-up, allowing the player to pick new weapons, passives, or upgrade existing equipment.
- **Destructible Objects**: Scatter the map with breakable props (Chansey, Saco, Tungtung, etc.) dropping gold, full-map vacuums, nuclear screen-clearing skulls, and restorative snacks.
- **Boss Waves**: Elite enemies with rainbow shader auras spawn periodically, dropping high-value **Boss Chests**.
- **Time-Based Survival**: A match lasts up to **300 seconds (5 minutes)** with scaling enemy population caps and intensity.

---

## 🕹️ Controls

| Input Key | Action | Description |
| :--- | :--- | :--- |
| <kbd>W</kbd> / <kbd>▲</kbd> | **Move Up** | Moves the player character North |
| <kbd>A</kbd> / <kbd>◄</kbd> | **Move Left** | Moves the player character West (flips sprite) |
| <kbd>S</kbd> / <kbd>▼</kbd> | **Move Down** | Moves the player character South |
| <kbd>D</kbd> / <kbd>►</kbd> | **Move Right** | Moves the player character East (flips sprite) |
| <kbd>Mouse Left-Click</kbd> | **Select / Interact** | Navigates menus, selects character, chooses level-up cards |
| <kbd>Mouse Cursor</kbd> | **Aim Direction** | Sets facing direction for targeted directional attacks |

---

## 👥 Playable Characters

Each hero starts with unique base stats, walking animations, portraits, and a signature starting weapon:

| Character | Title / Voice | Starting Weapon | Key Attributes |
| :--- | :--- | :--- | :--- |
| **Usagi** | *"¡Hya ha!"* | `ForceField` | High mobility (`Speed: +2.0`), rapid recovery (`+0.3 HP/s`), high magnet (`+4.0`). |
| **Megumin** | *"Explosion!"* | `MagicWand` | Massive burst damage, wide area scaling, high might. |
| **Hatsune Miku** | *Vocaloid Idol* | `LightningRing` | High agility, balanced baseline, fast projectile cycling. |
| **Creepy Bunny** | *Feral Rabbit* | `SingleShot` | High projectile rate, early-game pressure. |
| **Heavy Boar** | *Sturdy Beast* | `Asteroid` | High base armor, large maximum health pool. |
| **Purple Bitter** | *Shadow Entity* | `FlamePuddle` | Area-of-effect control, crowd melting damage. |

### Character Base Stats Breakdown
- **Max Health**: Determines total hit point capacity before defeat.
- **Recovery**: Passive HP restored per second.
- **Armor**: Flat damage reduction against physical enemy collisions.
- **Movement Speed**: Baseline movement velocity across the arena.
- **Might**: Global percentage multiplier for all weapon damage output.
- **Area**: Radius and footprint size multiplier for projectiles and aura attacks.
- **Magnet**: Pull radius for attracting XP gems and pickups toward the player.
- **Growth**: Percentage bonus applied to all collected experience points.
- **Luck**: Probability weight for multi-item chests and high-tier upgrades.

---

## ⚔️ Weapons & Evolution Synergies

### Base Weapons
1. **Magic Wand / Holy Wand**: Fires arcane bolts directed at the closest enemy within detection radius.
2. **Shuriken**: Launches spinning shurikens in alternating arcs around the player.
3. **Flame Puddle (Molotov)**: Hurls flasks creating persistent flaming puddles that damage enemies continuously.
4. **Force Field**: Emits a protective radial aura around the hero that periodically damages colliding targets.
5. **Asteroid / Sword**: Orbits swords/blades continuously around the hero, shielding against swarming mobs.
6. **Lightning Ring**: Calls down thunder strikes from the sky on random enemies in the area.

### Evolution & Upgrade Synergies

When a weapon reaches max rank and the player possesses the corresponding passive catalyst item, it evolves into an advanced form:

```
[ Base Weapon ]          +   [ Passive Catalyst ]       ==>   [ Evolved Weapon ]
Flame Puddle (Molotov)   +   Area                     ==>   Lava Puddle
Force Field              +   Max Health               ==>   Soul Field
Asteroid (Sword)         +   Recovery                 ==>   Huge Asteroid
Holy Wand                +   Projectile Upgrade       ==>   Holy Wand 2
Lightning Ring           +   Lightning Upgrade        ==>   Lightning Loop
Shuriken                 +   Blade Upgrade            ==>   Demon Shuriken
```

---

## 🛡️ Passive Items

Passive items enhance the character's core attributes for the duration of the current run:

| Passive Item | Stat Boosted | Description |
| :--- | :--- | :--- |
| **Area** | `+Area` | Enlarges weapon attack size and explosion radii. |
| **Armor** | `+Armor` | Reduces damage taken per incoming enemy hit. |
| **Growth** | `+Growth` | Boosts XP gained from every collected gem. |
| **Luck** | `+Luck` | Enhances chest upgrade chances and item roll qualities. |
| **Magnet** | `+Magnet` | Increases collection radius for gems and items. |
| **Max Health** | `+Max HP` | Increases overall survivability ceiling. |
| **Might** | `+Might` | Amplifies overall damage dealt by all weapons. |
| **Movement Speed** | `+Speed` | Enhances dodging and kiting velocity. |
| **Recovery** | `+HP/s` | Constantly regenerates player health over time. |

---

## 👾 Bestiary & Wave Mechanics

### Enemy Types
- **Bat**: Rapid aerial flyer with erratic swarming patterns.
- **Seed**: Basic foot soldier that marches in large groups.
- **Pig**: Moderate speed, medium hit points.
- **Frog**: Hopping ground enemy with sudden bursts of velocity.
- **Demonium**: High-health demon mob appearing in mid-to-late waves.
- **Battle Rabbit**: Fast elite fighter with high damage.

### Dynamic Wave Progression
The **Spawner** (`spawner.tscn`) regulates the battle arena dynamically:
- **Active Enemy Cap**: Begins at **70** simultaneous enemies and scales linearly up to **260** at minute 5.
- **Separation & Culling**: Non-elite enemies that stray further than 500 units from the player are recycled.
- **Elite Spawns**: Mini-bosses that do not despawn, rendered with a glowing **Rainbow Outline Shader** (`rainbow_outline.gdshader`), 1.5× scale, and elevated hitpoints.
- **Boss Defeat**: Eliminating elite enemies drops a **Boss Chest**.

---

## 💎 Pickups & Destructibles

### Pickups
- **Green Gem**: Standard experience gem (`+1 XP`).
- **Blue Gem**: High-yield experience gem (`+5 XP`).
- **Gold Coins / Bags**: Meta-progression currency saved permanently.
- **Boss Chest**: Opens an upgrade roll granting free item upgrades and bonus gold.

### Destructible Objects
Cracking open world destructibles (`destructible.tscn`) has a chance to drop powerful field items:
- **Sandwich de la Muerte**: Instantly restores a large chunk of player health.
- **Vacuum (Imán)**: Magnetizes and draws every single experience gem on the entire map directly to the player.
- **Skull (Death)**: Triggers an instant screen-wide blast obliterating all non-boss mobs on screen.
- **Saco / Tungtung**: Drops large bundles of gold.

---

## 🌟 Meta-Progression & Save System

The game features persistent progress between runs handled by two autoloaded singletons:

1. **`SaveData`** (`scenes/autoloads/save_data.tscn`):
   - Stores cumulative **Gold** and purchased **Skill Tree** nodes.
   - Serializes data via Godot's `ConfigFile` directly to `user://player_data.cfg`.
2. **`Persistence`** (`scenes/autoloads/persistence.tscn`):
   - Carries the chosen character selection from the Character Select screen into the gameplay scene.
   - Calculates and applies permanent bonus stats from the Skill Tree to the player upon spawning.
3. **`SoundManager`** (`scenes/autoloads/sound_manager.tscn`):
   - Global sound effects player configured on dedicated audio buses (`SFX`, `Music`, `Master`).

---

## 📁 Project Folder Organization

The codebase is organized into modular directories:

```
capycalypse/
├── assets/                          # Raw visual and audio assets
│   ├── Audio/                      # Audio clips and sound effects
│   ├── Destructibles/              # Sprites for breakable objects (chansey, sack, etc.)
│   ├── Enemies/                    # Spritesheets for enemies (01-16, bat, boss sheets)
│   ├── Icons/                      # Dedicated game icons
│   │   ├── Characters/             # Hero selection icons (megu_icon, miku_icon, usagi_icon)
│   │   ├── Passives/               # Passive item icons (armor, boots, crown, magnet, etc.)
│   │   └── Weapons/                # Weapon icons (sword, wand, shuriken, molotov, etc.)
│   ├── Gems/                       # XP gems, coins, currency sprites
│   ├── Health/                     # Health bar textures
│   ├── Other/                      # Title and miscellaneous interface buttons
│   ├── Player/                     # Character walk sprites organized by hero (megu, miku, usagi)
│   ├── ProgressBar/                # Progress bar UI textures
│   ├── Tiles/                      # Map terrain and environment tileset (Forest tiles)
│   ├── UI/                         # General UI textures, panels, buttons, and fonts
│   └── Weapons/                    # Weapon VFX & projectile sprites (Projectiles/)
│
├── resources/                       # Godot .tres custom resource data instances
│   ├── Characters/                 # Character stats and equipment configurations
│   ├── Destructible/               # Destructible drop tables and definitions
│   ├── Enemies/                    # Enemy type definitions and SpriteFrames
│   ├── Others/                     # Miscellaneous resources
│   ├── Passives/                   # Passive item stat-boosting resources
│   ├── Pickups/                    # Pickups, gems, and chest definitions
│   └── Weapons/                    # Weapon stats, projectile links, and upgrade trees
│
├── scenes/                          # Game scenes and accompanying controllers
│   ├── autoloads/                  # Singletons (Persistence, SaveData, SoundManager)
│   ├── core/                       # Base class definitions (Character, Stats, Item, etc.)
│   ├── enemies/                    # Enemy actor (enemy.tscn) and wave Spawner (spawner.tscn)
│   ├── pickups/                    # Pickup items (pickups.tscn) and Destructibles
│   ├── player/                     # Main player controller (player.tscn, player.gd)
│   ├── ui/                         # Main menu, character selection, skill tree, HUD
│   ├── weapons/                    # Projectile actors, damaging areas, and damage numbers
│   └── world/                      # Main game level (test_scene.tscn)
│
├── shaders/                         # Visual shaders (.gdshader & materials)
│   ├── line_2d.gdshader            # Dynamic laser beam shader
│   ├── rainbow.tres                # Elite enemy material instance
│   └── rainbow_outline.gdshader    # Animated rainbow outline shader for bosses
│
├── default_bus_layout.tres          # Audio bus configuration
├── project.godot                    # Main Godot project configuration
├── .editorconfig                    # Code formatting rules
├── .gitignore                       # Godot 4 production ignore rules
└── README.md                        # Project documentation & specifications
```

---

## ⚙️ Technical Specifications

- **Engine Version**: Godot Engine 4.7+ (Forward+ Rendering Device, D3D12 / Vulkan backend)
- **Scripting Language**: GDScript 2.0 (typed resources, class names, export groups, UIDs)
- **Physics Engine**: Jolt Physics 2D / CanvasItems
- **Display Resolution**:
  - Stretch Mode: `canvas_items`
  - Aspect: `expand`
- **Audio Channels**: 3 buses (`Master`, `Music`, `SFX`)
- **Autoloads**:
  - `SoundManager` (`res://scenes/autoloads/sound_manager.tscn`)
  - `SaveData` (`res://scenes/autoloads/save_data.tscn`)
  - `Persistence` (`res://scenes/autoloads/persistence.tscn`)

---

## 🚀 Getting Started & Development

### Prerequisites
- Install **[Godot Engine 4.7+](https://godotengine.org/download)** (Standard 64-bit edition).

### Opening the Project in Godot Editor
1. Clone this repository:
   ```bash
   git clone https://github.com/camanrofo34/capycalypse.git
   ```
2. Open the Godot Project Manager.
3. Click **Import**, navigate to the cloned folder, select `project.godot`, and click **Import & Edit**.
4. Press <kbd>F5</kbd> to run the game from the Main Menu (`res://scenes/ui/main_menu.tscn`).

### Running via Command Line
```bash
# Run the game directly
godot --path .

# Run directly into the arena map
godot --path . "res://scenes/world/test_scene.tscn"

# Run headlessly for testing
godot --headless --path . "res://scenes/ui/main_menu.tscn" --quit-after 60
```
