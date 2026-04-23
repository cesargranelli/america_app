# America App — Fluxos de Telas

> Documento de referência para visualização dos fluxos de navegação do app.
> Os diagramas usam sintaxe Mermaid, compatível com Figma (plugin "Mermaid to Figma"),
> FigJam, draw.io, e visualizadores online como [mermaid.live](https://mermaid.live).

---

## Visão Geral da Navegação

```mermaid
flowchart TD
    START([Abertura do App]) --> AUTH_CHECK{Usuário autenticado?}
    AUTH_CHECK -->|Sim| HOME[🏠 Home Screen]
    AUTH_CHECK -->|Não| LOGIN[🔐 Login Screen]

    LOGIN -->|Entrar| AUTH_CHECK
    LOGIN -->|Cadastre-se| SIGNUP[📝 Signup Screen]
    SIGNUP -->|Cadastrar| AUTH_CHECK

    HOME -->|Menu Drawer| DRAWER{Menu Lateral}
    HOME -->|Logout| LOGIN

    DRAWER -->|Ligas| LEAGUE_REG[⚽ Liga - Cadastro]
    DRAWER -->|Campeonatos| CHAMP_LIST[🏆 Campeonatos - Lista]
    DRAWER -->|Conferências| CONF_LIST[🤝 Conferências - Lista]
    DRAWER -->|Divisões| DIV_LIST[📊 Divisões - Lista]
    DRAWER -->|Equipes| TEAM_LIST[👥 Equipes - Lista]
    DRAWER -->|Atletas| ATH_LIST[🏃 Atletas - Lista]
    DRAWER -->|Classificação| STANDINGS[📈 Classificação]

    CHAMP_LIST -->|Novo| CHAMP_REG[🏆 Campeonato - Cadastro]
    CONF_LIST -->|Nova| CONF_REG[🤝 Conferência - Cadastro]
    DIV_LIST -->|Nova| DIV_REG[📊 Divisão - Cadastro]
    TEAM_LIST -->|Nova| TEAM_REG[👥 Equipe - Cadastro]
    ATH_LIST -->|Novo| ATH_REG[🏃 Atleta - Cadastro]
```

---

## Fluxo de Autenticação

```mermaid
flowchart TD
    subgraph Autenticação
        A([App Inicia]) --> B{Firebase Auth\nUsuário logado?}
        B -->|Sim| C[Home Screen]
        B -->|Não| D[Login Screen]

        D --> E[Preencher Email + Senha]
        E --> F[Tap: Entrar]
        F --> G{AuthViewModel\nEstado}
        G -->|Loading| H[⏳ CircularProgressIndicator]
        G -->|Success| C
        G -->|Error| I[❌ SnackBar com erro]
        I --> D

        D --> J[Tap: Cadastre-se]
        J --> K[Signup Screen]
        K --> L[Preencher Nome + Email + Senha]
        L --> M[Tap: Cadastrar]
        M --> N{AuthViewModel\nEstado}
        N -->|Loading| O[⏳ CircularProgressIndicator]
        N -->|Success| C
        N -->|Error| P[❌ SnackBar com erro]
        P --> K
    end
```

---

## Fluxo da Home + Drawer

```mermaid
flowchart LR
    subgraph Home
        HOME[Home Screen\n"Bem-vindo ao America App!"]
        APPBAR[AppBar: America App]
        LOGOUT[🚪 Botão Logout]
    end

    subgraph Drawer["Menu Lateral (Drawer)"]
        HEADER[DrawerHeader\n"Menu"]
        M1[⚽ Ligas]
        M2[🏆 Campeonatos]
        M3[🤝 Conferências]
        M4[📊 Divisões]
        M5[👥 Equipes]
        M6[🏃 Atletas]
        M7[📈 Classificação]
    end

    HOME --- APPBAR
    APPBAR --- LOGOUT
    HOME --- HEADER
    HEADER --- M1
    HEADER --- M2
    HEADER --- M3
    HEADER --- M4
    HEADER --- M5
    HEADER --- M6
    HEADER --- M7
```

---

## Fluxo CRUD — Campeonatos

```mermaid
flowchart TD
    subgraph Campeonatos
        CL[Championship List Screen] -->|FAB +| CR[Championship Registration Screen]
        CR -->|Salvar| CL
        CL -->|Item da lista| CD[Detalhes / Edição]
    end
```

---

## Fluxo CRUD — Conferências

```mermaid
flowchart TD
    subgraph Conferências
        CFL[Conference List Screen] -->|FAB +| CFR[Conference Registration Screen]
        CFR -->|Selecionar Campeonato| CFR
        CFR -->|Salvar| CFL
    end
```

---

## Fluxo CRUD — Divisões

```mermaid
flowchart TD
    subgraph Divisões
        DL[Division List Screen] -->|FAB +| DR[Division Registration Screen]
        DR -->|Selecionar Conferência| DR
        DR -->|Salvar| DL
    end
```

---

## Fluxo CRUD — Equipes

```mermaid
flowchart TD
    subgraph Equipes
        TL[Team List Screen] -->|FAB +| TR[Team Registration Screen]
        TR -->|Selecionar Divisão| TR
        TR -->|Salvar| TL
    end
```

---

## Fluxo CRUD — Atletas

```mermaid
flowchart TD
    subgraph Atletas
        AL[Athlete List Screen] -->|FAB +| AR[Athlete Registration Screen]
        AR -->|Selecionar Equipe| AR
        AR -->|Salvar| AL
    end
```

---

## Fluxo de Gerenciamento de Jogo

```mermaid
flowchart TD
    subgraph Jogo
        GM[Game Management Screen] -->|Preencher formulário| GM
        GM -->|Registrar Jogada| PLAY[Jogada salva\nLista atualizada]
        GM -->|Ícone Timeline| GT[Game Timeline Screen]
        GT -->|Refresh| GT
        GT -->|Voltar| GM
    end

    subgraph "Formulário de Jogada"
        F1[Tipo de Jogada\nrun/pass/punt/kickoff/fieldGoal/touchdown/safety]
        F2[Descrição]
        F3[Quarto: 1-4]
        F4[Tempo: MM:SS]
        F5[Descida: 1-4]
        F6[Jardas para Avançar]
        F7[Linha de Jardas: 0-100]
    end

    GM --- F1
    GM --- F2
    GM --- F3
    GM --- F4
    GM --- F5
    GM --- F6
    GM --- F7
```

---

## Fluxo de Classificação (Standings)

```mermaid
flowchart TD
    subgraph Classificação
        S[Standings Screen] -->|Carrega| SL{Estado}
        SL -->|Loading| SP[⏳ CircularProgressIndicator]
        SL -->|Error| SE[❌ Mensagem de erro]
        SL -->|Vazio| SV[📭 "Nenhuma classificação disponível"]
        SL -->|Dados| ST[📊 Tabela\nTime | V | D | Pts]
    end
```

---

## Hierarquia de Entidades

```mermaid
flowchart TD
    LEAGUE[Liga] --> CHAMPIONSHIP[Campeonato]
    CHAMPIONSHIP --> CONFERENCE[Conferência]
    CONFERENCE --> DIVISION[Divisão]
    DIVISION --> TEAM[Equipe]
    TEAM --> ATHLETE[Atleta]
    CHAMPIONSHIP --> STANDING[Classificação]
    TEAM --> GAME[Jogo]
    GAME --> PLAY[Jogada]
```

---

## Inventário de Telas

| # | Tela | Arquivo | Tipo |
|---|------|---------|------|
| 1 | Login | `ui/auth/views/login_screen.dart` | Formulário |
| 2 | Cadastro | `ui/auth/views/signup_screen.dart` | Formulário |
| 3 | Home | `ui/home/views/home_screen.dart` | Dashboard + Drawer |
| 4 | Cadastro de Liga | `ui/league/views/league_registration_screen.dart` | Formulário |
| 5 | Lista de Campeonatos | `ui/championship/views/championship_list_screen.dart` | Lista |
| 6 | Cadastro de Campeonato | `ui/championship/views/championship_registration_screen.dart` | Formulário |
| 7 | Lista de Conferências | `ui/conference/views/conference_list_screen.dart` | Lista |
| 8 | Cadastro de Conferência | `ui/conference/views/conference_registration_screen.dart` | Formulário |
| 9 | Lista de Divisões | `ui/division/views/division_list_screen.dart` | Lista |
| 10 | Cadastro de Divisão | `ui/division/views/division_registration_screen.dart` | Formulário |
| 11 | Lista de Equipes | `ui/team/views/team_list_screen.dart` | Lista |
| 12 | Cadastro de Equipe | `ui/team/views/team_registration_screen.dart` | Formulário |
| 13 | Lista de Atletas | `ui/athlete/views/athlete_list_screen.dart` | Lista |
| 14 | Cadastro de Atleta | `ui/athlete/views/athlete_registration_screen.dart` | Formulário |
| 15 | Gerenciamento de Jogo | `ui/game/views/game_management_screen.dart` | Formulário + Lista |
| 16 | Timeline do Jogo | `ui/game/views/game_timeline_screen.dart` | Lista |
| 17 | Classificação | `ui/standings/views/standings_screen.dart` | Tabela |

---

## Como usar este documento

### Figma
1. Instale o plugin **"Mermaid to Figma"** no Figma
2. Copie qualquer bloco de código Mermaid deste documento
3. Cole no plugin para gerar o diagrama visual
4. Ajuste cores e layout conforme necessário

### FigJam
1. Use o widget **Mermaid** disponível no FigJam
2. Cole os diagramas diretamente

### draw.io / diagrams.net
1. Acesse [draw.io](https://app.diagrams.net/)
2. Use Extras → Edit Diagram e cole o código Mermaid
3. Ou use o formato de importação Mermaid

### Mermaid Live Editor
1. Acesse [mermaid.live](https://mermaid.live)
2. Cole qualquer diagrama para visualização e exportação como PNG/SVG

### VS Code
1. Instale a extensão **"Markdown Preview Mermaid Support"**
2. Abra este arquivo e use o preview do Markdown
