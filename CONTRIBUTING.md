<div align="center">

# 🤝 Contributing to **RAINZ'S Arch Hyprland Rice**

*First off, thank you for considering contributing to this dotfiles collection!*
Whether you're fixing a typo, squashing a bug, or proposing a new feature for **Hyprland** or **Noctalia**, your help is genuinely appreciated.

💙 *It's people like you that make the Linux community incredible.*

</div>

---

## 🗂️ Table of Contents

* 💡 [How Can I Contribute?](#-how-can-i-contribute)
* 🐛 [Reporting Bugs](#-reporting-bugs)
* 🚀 [Suggesting Enhancements](#-suggesting-enhancements)
* 🔁 [Submitting Pull Requests](#-submitting-pull-requests)
* 🎨 [Styleguides](#-styleguides)

  * ✍️ [Commit Messages](#-commit-messages)
  * ⚙️ [Configuration Guidelines](#-configuration-guidelines)
* 🛠️ [Setting Up for Development](#-setting-up-for-development)

---

## 💡 How Can I Contribute?

There are many ways to contribute:

* Reporting bugs 🐛
* Suggesting improvements 🚀
* Submitting pull requests 🔁
* Improving documentation 📝

---

## 🐛 Reporting Bugs

Before creating a new issue, **check existing issues first**.

If it's new, include:

* 📝 **Clear and descriptive title**
* 🖥️ **Environment details**

  * GPU (NVIDIA / AMD / Intel)
  * Resolution / monitor setup
* 🔁 **Steps to reproduce**
* ✅ **Expected behavior**
* ❌ **Actual behavior**
* 📄 **Logs**, for example:

  ```bash
  journalctl --user -u hyprland
  ```

---

## 🚀 Suggesting Enhancements

Got an idea to improve the setup?

* Use the **Enhancement** label
* Clearly explain:

  * What the feature does
  * Why it’s useful
* Add extras if possible:

  * Screenshots 📸
  * Mockups 🎨
  * Useful tools/plugins (Fish, Starship, etc.)

---

## 🔁 Submitting Pull Requests

1. **Fork** the repository
2. Create a branch from `main`
3. Clone your fork:

```bash
git clone https://github.com/<your-username>/dotfiles.git
```

4. Make your changes
5. Test everything locally ⚡
6. Ensure scripts are **well commented**
7. Test configs:

   ```bash
   stow -nvt ~/.config <package-name>
   ```
8. Submit your PR with:

   * Clear description
   * Reason for changes

---

## 🎨 Styleguides

### ✍️ Commit Messages

Keep commits clean and readable:

* Use **imperative mood**

  * ✅ `Add feature`
  * ❌ `Added feature`
* First line ≤ **50 characters**

**Conventional styles:**

* ✨ `feat:` → New features
* 🐛 `fix:` → Bug fixes
* 💄 `style:` → UI / aesthetics
* 📝 `docs:` → Documentation
* 🔧 `chore:` → Maintenance

---

### ⚙️ Configuration Guidelines

#### 🪟 Hyprland

* Keep configs modular:

  * `hyprland.conf`
  * `window_rules.conf`
* Use variables for:

  * gaps
  * borders
  * animations

#### 🌙 Noctalia Shell

* Follow color palette strictly:

  * Background: `#141316`
  * Accent Pink: `#eeb8cb`
* Document new plugins/modules

#### 📜 Scripts

* Use **clean bash / POSIX**
* Maintain consistent UI output
* Comment important logic

#### 📦 Modularity (IMPORTANT)

* Use **GNU Stow structure**
* Each app gets its own directory
* Keep configs isolated and reusable

---

## 🛠️ Setting Up for Development

Recommended workflow:

1. Install **GNU Stow**
2. Clone into a test directory:

   ```bash
   ~/dotfiles-dev
   ```
3. Backup your existing configs ⚠️
4. Test modules individually:

   ```bash
   stow -t ~/.config -d ~/dotfiles-dev <package>
   ```

---

### 🧠 Note

* Neovim config is maintained **separately**
* Submit Neovim PRs to its respective repo

---

<div align="center">

## 🚀 Thank you for helping make Linux beautiful!

</div>
