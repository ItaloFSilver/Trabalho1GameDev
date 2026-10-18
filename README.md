# 🏰 Castlevania NES — Remake em Godot

> Réplica do clássico **Castlevania (1986)** do Nintendo Entertainment System (NES), desenvolvida como projeto prático para a disciplina **Desenvolvimento de Jogos (DCC148)** da **Universidade Federal de Juiz de Fora (UFJF)**.

> **Aviso:** Este projeto é puramente acadêmico, sem fins lucrativos. A franquia *Castlevania* pertence à Konami.

---

## 👥 Integrantes

| Nome | Matrícula | GitHub |
| :--- | :---: | :---: |
| **Gustavo Bersan Moreira Campos** | `202435019` | [@GustavoBersan](https://github.com/GustavoBersan) |
| **Ítalo Fagundes Silvério** | `202435020` | [@ItaloFSilver](https://github.com/ItaloFSilver) |

---

## 📚 Informações Acadêmicas

* **Instituição:** Universidade Federal de Juiz de Fora (UFJF)
* **Instituto:** Instituto de Ciências Exatas (ICE)
* **Departamento:** Departamento de Ciência da Computação (DCC)
* **Disciplina:** DCC148 — Desenvolvimento de Jogos
* **Engine:** [Godot Engine v4.x](https://godotengine.org/)

---

## 🎮 Sobre o Jogo

O objetivo deste projeto é recriar fielmente a jogabilidade, visual retro e dinâmicas do *Castlevania* original de NES. O foco está na fidelidade das mecânicas clássicas de *action-platformer* da era 8-bits.

### 🎯 Funcionalidades e Mecânicas Implementadas

- [x] **Movimentação Clássica:**
  - Pulo com trajetória rígida (*pulo travado* no ar).
  - Animação e física de subir e descer escadas.
  - Animação e mecânica de abaixar e dar chicotadas no chão.
- [x] **Sistema de Combate e Armas:**
  - **Vampire Killer:** Ataque com chicote com upgrades de alcance e poder.
  - **Sub-Armas:** Adaga, Machado, Água Benta e Relógio do Tempo.
- [x] **Inimigos & I.A. Básica:**
  - Comportamentos clássicos para Zumbis, Morcegos, Esqueletos e Cavaleiros.
  - Lógica de invulnerabilidade temporária (knockback ao sofrer dano).
- [x] **Interface (HUD):**
  - Barra de vida do jogador e do chefe da fase.
  - Contador de corações (munição das sub-armas).
  - Placar de pontuação, estágio e tempo restante.
- [x] **Design de Fases & Áudio:**
  - Tilemaps fiéis ao visual 8-bits com suporte a colisão pixel-perfect.
  - Trilha sonora original em Chiptune e efeitos sonoros retro.

---

## ⌨️ Controles

| Ação | Teclado | Gamepad (Xbox / PlayStation) |
| :--- | :---: | :---: |
| **Mover Esquerda / Direita** | `A` / `D` ou `Setas` | `D-Pad` / `Analógico Esquerdo` |
| **Subir Escada** | `W` ou `Seta Cima` | `D-Pad Cima` |
| **Descêr Escada / Abaixar** | `S` ou `Seta Baixo` | `D-Pad Baixo` |
| **Pular** | `Espaço` ou `K` | Botão `A` / `Cross` |
| **Atacar (Chicote)** | `J` | Botão `X` / `Square` |
| **Usar Sub-Arma** | `W` + `J` (Cima + Ataque) | `D-Pad Cima` + `X` / `Square` |
| **Pausar Jogo** | `Enter` / `Esc` | `Start` / `Options` |

---

## 📜 Referências

Este jogo foi desenvolvido como um projeto acadêmico e ganhou vida graças ao uso de ferramentas open-source e recursos disponibilizados por artistas da comunidade. 

Gostaria de deixar os devidos créditos e agradecimentos:

* **Ansimuz:** Agradecimento especial pelos pacotes de pixel art, cenários e banners de interface utilizados no jogo.
  * **Apoie o trabalho do criador:** [Patreon do Ansimuz](https://www.patreon.com/cw/ansimuz)
  * **Link dos Assets:** [Assets Gothicvania](https://amiten.itch.io/gothicvania)

---
## 📁 Estrutura do Projeto

```text
.
├── assets/
│   ├── audio/          # Musicas (BGM) em Chiptune e Efeitos Sonoros (SFX)
│   ├── fonts/          # Fontes bitmap / pixel art
│   └── sprites/        # Spritesheets do Player, Inimigos, Tilemaps e HUD
├── scenes/
│   ├── actors/         # Player, Inimigos e Chefes (Cenas .tscn)
│   ├── items/          # Coletaveis, upgrades e sub-armas
│   ├── levels/         # Fases e estagios do castelo
│   ├── ui/             # HUD, Tela de Titulo, Game Over e Menus
│   └── world/          # Elementos interativos (Escadas, Portas, Candelabros)
├── scripts/
│   ├── actors/         # GDScripts para movimentacao, vida e I.A.
│   ├── autoload/       # GameManager, AudioManager e Globais
│   └── components/     # Hitbox, Hurtbox e gerenciadores reutilizaveis
├── project.godot       # Arquivo de configuracao da Godot Engine
└── README.md           # Documentacao do projeto
