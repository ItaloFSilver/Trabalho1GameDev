# 🏰 Castlevania NES — Remake em Godot

> Réplica do clássico **Castlevania (1986)** do Nintendo Entertainment System (NES), desenvolvida como projeto prático para a disciplina **Desenvolvimento de Jogos (DCC148)** da **Universidade Federal de Juiz de Fora (UFJF)**.

> **Aviso:** Este projeto é puramente acadêmico, sem fins lucrativos. A franquia *Castlevania* pertence à Konami.

---

## 👥 Integrantes

| Nome | Matrícula | GitHub |
| :--- | :---: | :---: |
| **Gustavo Bersan Moreira Campos** | `202435019` | [@Bersan121](https://github.com/Bersan121) |
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
  - Animação e mecânica de abaixar 
- [x] **Sistema de Combate e Armas:**
  - **Vampire Killer:** Ataque com Espada.
- [x] **Inimigos & I.A. Básica:**
  - Comportamentos clássicos para Zumbis.
  - Lógica de invulnerabilidade temporária (knockback ao sofrer dano).
- [x] **Interface (HUD):**
  - Barra de vida do jogador e do chefe da fase.
- [x] **Design de Fases & Áudio:**
  - Cenário criado com tilemaps
---

## ⌨️ Controles

| Ação | Teclado | Gamepad (Xbox / PlayStation) |
| :--- | :---: | :---: |
| **Mover Esquerda / Direita** |`Setas` | `D-Pad` / `Analógico Esquerdo` |
| **Subir Escada** | `Seta Cima` | `D-Pad Cima` |
| **Descêr Escada / Abaixar** | `Seta Baixo` | `D-Pad Baixo` |
| **Pular** | `Z` | Botão `A` / `Cross` |
| **Atacar (Chicote)** | `X` | Botão `X` / `Square` |

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
## 📁 Assets

