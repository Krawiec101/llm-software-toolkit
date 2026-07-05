# LLM Software Toolkit

LLM Software Toolkit to zestaw lekkich workflowow i skillow pomagajacych w tworzeniu oprogramowania z agentami LLM. Repo jest agnostyczne wzgledem konkretnego modelu albo narzedzia: te same pliki zrodlowe maja byc uzywalne w Codex i Claude Code.

Pierwsza wersja skupia sie na malym, czytelnym fundamencie:

- CLI do instalacji i aktualizacji toolkitu w projektach docelowych.
- Workflow `new-feature` do prowadzenia pracy nad nowa funkcja.
- Samodzielne skille do dopracowania biznesowego, planowania, frontendu, backendu, testow i release tagowania.
- Adaptery opisujace uzycie tych samych workflowow w Codex i Claude Code.
- Changelog oraz lessons learned, zeby kolejne iteracje byly oparte na wnioskach.

## Instalacja w projekcie docelowym

Uruchom CLI z lokalnego repo toolkitu:

```bash
python <toolkit-repo>/cli/toolkit.py install --target <project-path>
```

Instalacja utworzy:

- `.llm-toolkit/toolkit/` - zarzadzana kopia workflowow, skillow, adapterow i dokumentacji.
- `.llm-toolkit/manifest.json` - manifest z informacja o zrodle instalacji i ostatniej aktualizacji.

Aktualizacja projektu po zmianach w tym repo:

```bash
python <toolkit-repo>/cli/toolkit.py update --target <project-path>
```

Status instalacji:

```bash
python <toolkit-repo>/cli/toolkit.py status --target <project-path>
```

Katalog `.llm-toolkit/toolkit/` jest zarzadzany przez CLI. Reczne zmiany w tym katalogu moga zostac nadpisane przez `update`.

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

Skill `release-version` przygotowuje konkretna wersje w formacie SemVer `vX.Y.Z`. Sprawdza gotowosc repo, changelog i lessons learned, tworzy lokalny annotated tag oraz pokazuje komende do recznego push.

## Zasady rozwoju

- Kazda istotna zmiana trafia do `CHANGELOG.md`.
- Wnioski z bledow procesu, niejasnych instrukcji albo zmian w workflowach trafiaja do `docs/lessons-learned.md`.
- Adaptery dla narzedzi maja byc cienkie i nie powinny duplikowac tresci workflowow.
- CLI v1 dziala lokalnie, bez pobierania z remote URL i bez zewnetrznych zaleznosci.
