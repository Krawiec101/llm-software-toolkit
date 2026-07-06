# LLM Software Toolkit

LLM Software Toolkit to zestaw lekkich workflowow i skillow pomagajacych w tworzeniu oprogramowania z agentami LLM. Repo jest agnostyczne wzgledem konkretnego modelu albo narzedzia: te same pliki zrodlowe maja byc uzywalne w Codex i Claude Code.

Pierwsza wersja skupia sie na malym, czytelnym fundamencie:

- Instalatory do synchronizacji toolkitu w projektach docelowych.
- Workflow `new-feature` do prowadzenia pracy nad nowa funkcja.
- Samodzielne skille do dopracowania biznesowego, planowania, frontendu, backendu, testow i release tagowania.
- Adaptery opisujace uzycie tych samych workflowow w Codex i Claude Code.
- Changelog oraz lessons learned, zeby kolejne iteracje byly oparte na wnioskach.

## Instalacja w projekcie docelowym

Najprosciej uruchom instalator z katalogu projektu docelowego. Instalator pobierze publiczne repo toolkitu do lokalnego cache i zsynchronizuje `.llm-toolkit/toolkit/`.

Windows PowerShell:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "iex (irm https://raw.githubusercontent.com/Krawiec101/llm-software-toolkit/main/install.ps1)"
```

macOS albo Linux:

```bash
curl -fsSL https://raw.githubusercontent.com/Krawiec101/llm-software-toolkit/main/install.sh | sh
```

Domyslnie instalator pobiera branch `main`. Wersje albo fork mozna wskazac zmiennymi srodowiskowymi:

```bash
LLM_TOOLKIT_REF=v0.1.1 LLM_TOOLKIT_REPO_URL=https://github.com/Krawiec101/llm-software-toolkit.git sh -c "$(curl -fsSL https://raw.githubusercontent.com/Krawiec101/llm-software-toolkit/main/install.sh)"
```

Instalacja utworzy:

- `.llm-toolkit/toolkit/` - zarzadzana kopia workflowow, skillow, adapterow i dokumentacji.
- `.llm-toolkit/manifest.json` - manifest z informacja o zrodle instalacji i ostatniej aktualizacji.

Ponowne uruchomienie tej samej komendy aktualizuje zarzadzana kopie i zachowuje pierwotna date instalacji w manifescie.

Katalog `.llm-toolkit/toolkit/` jest zarzadzany przez instalator. Reczne zmiany w tym katalogu moga zostac nadpisane przy kolejnej synchronizacji.

## Kontekst projektu docelowego

Workflowy i skille maja zaczynac od zebrania lokalnego kontekstu projektu w tej kolejnosci:

1. `project.yaml`, jesli istnieje.
2. `AGENTS.md` albo `agent.md`.
3. `CLAUDE.md`.
4. Manifesty technologiczne, np. `package.json`, `pyproject.toml`, `composer.json`, `go.mod`.

Jesli informacji brakuje, agent ma zapisac jawne zalozenia zamiast zgadywac po cichu.

## Workflowy

Pierwszy workflow znajduje sie w `workflows/new-feature/WORKFLOW.md`. Prowadzi przez:

1. Dopracowanie pomyslu biznesowego.
2. Plan implementacji dla agentow frontend, backend i test.
3. Implementacje frontendu.
4. Implementacje backendu.
5. Weryfikacje testowa i raport luk.

## Skille

Skille sa male i samodzielne. Mozna ich uzywac jako czesci workflowu albo osobno:

- `skills/business-refinement/SKILL.md`
- `skills/implementation-plan/SKILL.md`
- `skills/frontend-agent/SKILL.md`
- `skills/backend-agent/SKILL.md`
- `skills/test-agent/SKILL.md`
- `skills/release-version/SKILL.md`

## Release

Skill `release-version` przygotowuje i publikuje kolejna wersje na podstawie typu zmiany: `patch`, `minor` albo `major`. Wersja jest liczona z tagow na `origin`, a agent przygotowuje release notes, pyta tylko o potwierdzenie tytulu commita, pushuje branch i wypycha dokladnie jeden annotated tag.

## Zasady rozwoju

- Kazda istotna zmiana trafia do `CHANGELOG.md`.
- Wnioski z bledow procesu, niejasnych instrukcji albo zmian w workflowach trafiaja do `docs/lessons-learned.md`.
- Adaptery dla narzedzi maja byc cienkie i nie powinny duplikowac tresci workflowow.
- Skrypty `install.ps1` i `install.sh` synchronizuja lokalna kopie toolkitu z publicznego repo Git.
