# Desktop Snazz: WM-only Mac-flavored Sway

## Problem
How might we level up daily ergonomics of this Sway box for a Mac+nvim-
reflex coder who works mostly remote, without adding fragile config or
in-app text-op remapping?

## Direction
Three independent bundles, all additive:

- **Bundle A — Sway config.** Mac-like WM keybinds + nvim window grammar
  + dialog floating rules + named workspace assignments.
- **Bundle B — Launcher.** Swap wofi → fuzzel, bind Super+Space
  (Mac Cmd+Space parallel).
- **Bundle C — Shell.** zoxide + fzf in zshrc (atuin deferred; too
  invasive for a first pass).

In-app text ops (Cmd+C/V/A inside apps) explicitly out — would need
keyd/kanata; fragility tax not justified when Ctrl+C/V is already reflex.

## Assumptions to validate
- [ ] Firefox/Ozone dialogs advertise `window_role="dialog"` (10-sec
      test on first launch; escape hatch is per-app-id rules)
- [ ] fuzzel's calc/emoji/actions actually get used (honest answer: if
      no, this bundle is cosmetic; wofi was fine)
- [ ] Current sway keybind habits are thin enough to override without
      pain (likely — only ~1 month on sway, mostly stock config)

## MVP scope

**In:**
- Dialog floating rule: `for_window [window_role="dialog|pop-up"] floating enable`
- Keybinds: Super+Space → launcher, Super+Q → close, Super+T → terminal,
  Super+Tab / Super+Shift+Tab → cycle focus, Super+s/v → split horizontal
  /vertical (nvim window grammar)
- Named workspaces: `1:term`, `2:web`, `3:ozone`, `4:misc`
- Workspace assignments: Firefox → 2:web, Chromium/Ozone → 3:ozone
- fuzzel install + Super+Space binding (keep wofi package as safety net,
  just unbound)
- zoxide install + `eval "$(zoxide init zsh)"` in zshrc

**Out:**
- keyd/kanata for in-app Cmd+C/V/A — rejected for fragility
- atuin — intrusive, defer until specifically wanted
- sway-session / i3-resurrect layout persistence — fragile, maintenance tax
- Weather/calendar bar modules — visual-only, not ergonomic

## Not Doing (and why)
- **keyd for Cmd+C/V** — daemon + kernel coupling; breaks on libinput
  updates; Ctrl+C/V is already muscle memory at this point.
- **Layout persistence across close/reopen** — structurally hard in any
  tiling WM; accept the inherent limit rather than fight it with fragile
  scripts.
- **atuin** — rewrites `↑` history behavior in ways that can feel
  intrusive; worth trying only if you specifically want cross-machine
  shell-history search.
- **Wholesale wofi package removal** — kept as fallback; just unbound
  from any keys. Zero cost to keep it installed.

## Open questions
- Additional workspace assignments (Slack/Discord/Zoom/vscode)? Starting
  with just Firefox and Chromium; easy to add later.
- Keep a transition period with both old ($mod+d, $mod+Return) and new
  keybinds active? Default: hard cut — easier to build new muscle memory
  when old key doesn't work.
