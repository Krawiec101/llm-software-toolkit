# LLM Software Toolkit

LLM Software Toolkit to plugin-first zestaw workflowow i skillow pomagajacych w pracy developerskiej z agentami LLM. Runtime toolkitu znajduje sie w `plugins/llm-software-toolkit/` i jest przeznaczony do instalacji bezposrednio przez Codex albo Claude Code.

Repo jest agnostyczne wzgledem konkretnego modelu, ale nie udaje, ze wszystkie narzedzia maja identyczny mechanizm dystrybucji. Wspolne sa workflowy i skille, a roznice instalacyjne sa opisane w manifestach pluginow i adapterach.

## Instalacja przez plugin

Kanoniczny plugin:

```text
plugins/llm-software-toolkit/
```

Claude Code:

```text
/plugin marketplace add <repo-url-or-local-path>
/plugin install llm-software-toolkit@llm-software-toolkit
```

Codex:

```text
codex plugin marketplace add <repo-url-or-local-path>
codex plugin add llm-software-toolkit@llm-software-toolkit
```

Repo zawiera marketplace dla Codex w `.agents/plugins/marketplace.json` oraz marketplace dla Claude Code w `.claude-plugin/marketplace.json`. W projektach docelowych nie kopiuj workflowow recznie; instaluj plugin natywnie w narzedziu.

## Dostepne workflowy

- `new-feature` - prowadzi prace nad nowa funkcja od doprecyzowania wymagan przez plan, implementacje, testy, lokalna walidacje i opis PR.

`implement-feature` jest nazwa znaczeniowa dla `new-feature`, nie osobnym katalogiem. `debug-bug` nie jest dostarczany w tej wersji.

## Skille pluginu

Najwazniejsze entrypointy:

- `llm-software-toolkit:new-feature`
- `llm-software-toolkit:list-workflows`
- `llm-software-toolkit:business-refinement`
- `llm-software-toolkit:implementation-plan`
- `llm-software-toolkit:frontend-agent`
- `llm-software-toolkit:backend-agent`
- `llm-software-toolkit:test-agent`
- `llm-software-toolkit:ship` - przygotowuje changelog i bezpieczny lokalny commit bez pushowania, tagowania ani publikacji.
- `llm-software-toolkit:release-version`

Skille moga byc uzywane osobno albo jako etapy workflowu `new-feature`. `ship` zamyka prace lokalnym commitem w projekcie docelowym, a `release-version` publikuje wersje samego pluginu.

## Kontekst projektu docelowego

Workflowy i skille maja zaczynac od zebrania lokalnego kontekstu projektu w tej kolejnosci:

1. `project.yaml`, jesli istnieje.
2. `AGENTS.md` albo `agent.md`.
3. `CLAUDE.md`.
4. Manifesty technologiczne, np. `package.json`, `pyproject.toml`, `composer.json`, `go.mod`.

Jesli informacji brakuje, agent ma zapisac jawne zalozenia zamiast zgadywac po cichu.

## Dokumentacja

- `plugins/llm-software-toolkit/README.md` - instalacja i uzycie pluginu.
- `docs/authoring-guide.md` - zasady tworzenia nowych workflowow i skilli.
- `docs/compatibility.md` - roznice Codex i Claude Code.
- `docs/project-onboarding.md` - jak wlaczyc plugin w projekcie bez recznego kopiowania.
- `docs/lessons-learned.md` - wnioski z rozwoju toolkitu.

## Zasady rozwoju

- Runtime toolkitu mieszka w `plugins/llm-software-toolkit/`.
- Workflowy sa pierwszorzednym elementem pluginu, obok skilli, agentow, hookow i MCP.
- Adaptery dla narzedzi maja byc cienkie i nie powinny duplikowac tresci workflowow.
- Kazda istotna zmiana trafia do `CHANGELOG.md`.
- Wnioski z bledow procesu, niejasnych instrukcji albo zmian w workflowach trafiaja do `docs/lessons-learned.md`.
