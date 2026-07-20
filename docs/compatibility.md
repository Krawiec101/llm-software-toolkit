# Compatibility

The toolkit is shared by Codex and Claude Code at the workflow and skill level, but each tool has its own plugin packaging and invocation details.

## Shared artifacts

These artifacts are common runtime content:

- `plugins/llm-software-toolkit/workflows/`
- `plugins/llm-software-toolkit/skills/`
- `plugins/llm-software-toolkit/adapters/`

The workflow files define the procedure. The skill files provide native invocation entrypoints. The adapters describe tool-specific usage without duplicating workflow logic.

## Codex

Codex uses:

- `plugins/llm-software-toolkit/.codex-plugin/plugin.json`
- `.agents/plugins/marketplace.json`

Install the plugin from the `llm-software-toolkit` marketplace and invoke namespaced skills such as:

```text
codex plugin marketplace add <repo-url-or-local-path>
codex plugin add llm-software-toolkit@llm-software-toolkit
llm-software-toolkit:new-feature
```

Codex must support fresh isolated execution subagents to run `new-feature`. Agent templates remain optional, but isolation and artifact-packet handoff are mandatory.

## Claude Code

Claude Code uses:

- `plugins/llm-software-toolkit/.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`

Install the plugin from the marketplace and invoke namespaced skills such as:

```text
/llm-software-toolkit:new-feature
```

Claude Code must create fresh Task subagents for every used frontend, backend and test role. Project-defined agents are compatible only when invoked without the lead conversation history and with the required artifact packet.

## Workflow availability

`new-feature` is shared by Codex and Claude Code and requires native isolated subagent capability. Missing isolation is a blocker, not a local-execution fallback. Focused frontend, backend and test skills can still be invoked standalone outside this workflow.

`debug-bug` is not included in this plugin release. If added later, decide whether it should be a workflow, a skill, a Claude Code agent, a Codex template, a prompt command, documentation, or a combination based on the classification rules in `docs/authoring-guide.md`.

## What should stay tool-specific

Keep these details in adapters, manifests or marketplace metadata:

- Plugin installation commands.
- Namespaced invocation syntax.
- Tool-specific agent or subagent configuration.
- Hook and MCP registration.
- Permission and trust prompts.

Do not fork workflow logic between Codex and Claude Code unless a tool-specific capability changes the actual procedure.
