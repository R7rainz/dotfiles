
---

name: "Bug report"
about: Report an issue to help improve stability
title: "[BUG] "
labels: bug
assignees: ""
-------------

## Description

Provide a clear and concise description of the issue.

---

## Affected Component

* [ ] Installation Script (`install.sh`)
* [ ] Hyprland (window manager, rules, keybinds)
* [ ] Noctalia Shell (bar, notifications, lockscreen)
* [ ] Terminal / Shell (Ghostty, Kitty, Wezterm, Fish)
* [ ] Theme / UI (Zen Browser, Yazi, fonts)
* [ ] Other: ___

---

## Steps to Reproduce

1. Go to `...`
2. Execute `...`
3. Observe the issue

---

## Expected vs Actual Behavior

**Expected:**
Describe what should happen

**Actual:**
Describe what actually happens

---

## Environment

* **OS:** Arch Linux (or derivative)
* **GPU:** (e.g., NVIDIA / AMD / Intel)
* **Installation Method:** (`install.sh` / manual `stow`)
* **Hyprland Version:**

  ```bash
  hyprctl version
  ```
* **Noctalia Version:**

  ```bash
  pacman -Q noctalia-shell
  ```

---

## Logs

<details>
<summary>Hyprland Logs</summary>

```bash
journalctl --user -u hyprland
```

Paste output here

</details>

<details>
<summary>Noctalia Logs</summary>

```bash
journalctl --user -f | grep -i noctalia
```

Paste output here

</details>

---

## Additional Context

Add screenshots, recordings, or any extra context if relevant.
