# [ POHEBEYY // DOTFILES_HYPRLAND ]

**Arch Linux / Hyprland (Lua)**
---

<img width="1915" height="1079" alt="image" src="https://github.com/user-attachments/assets/69541148-bd18-4f02-ab53-7d5e2868bde9" />

---

<img width="1920" height="1062" alt="image" src="https://github.com/user-attachments/assets/b2d39da7-6e6c-4a6e-a318-21a50b6b5593" />


---

Минималистичная и производительная конфигурация рабочего окружения на базе [`swrneko/dots-next`](https://github.com/swrneko/dots-next) 

---

##  01. Зависимости (Arch Linux)

### Базовые пакеты (pacman)
```bash
sudo pacman -S --needed \
    hyprland hyprlock \
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    xorg-xwayland \
    grim slurp wl-clipboard \
    brightnessctl playerctl wireplumber \
    kitty nemo btop firefox \
    awww noctalia \
    ttf-0xproto-nerd noto-fonts-cjk
```

### Колесо обоев (AUR)
Для работы дугового виджета выбора обоев (`SUPER + W`) требуется `quickshell-git`:
```bash
yay -S --needed quickshell-git
```

---

##  02. Установка

1. **Клонируй репозиторий:**
   ```bash
   git clone https://github.com/pohebeyy/dotfiles_hyperland.git ~/dotfiles
   cd ~/dotfiles
   ```

2. **Сделай бэкап текущих конфигов (на всякий случай):**
   ```bash
   mkdir -p ~/dotfiles_backup
   cp -r ~/.config/hypr ~/dotfiles_backup/ 2>/dev/null || true
   ```

3. **Запусти скрипт установки (создаст симлинки и папку под обои):**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

4. **Назначь Firefox браузером по умолчанию в системе:**
   ```bash
   xdg-settings set default-web-browser firefox.desktop
   xdg-mime default firefox.desktop x-scheme-handler/http x-scheme-handler/https text/html
   ```

5. **Закинь обои** в `~/Pictures/wallpapers/` (поддерживаются `.jpg`, `.jpeg`, `.png`, `.webp`) и перезагрузи конфиг:
   ```bash
   hyprctl reload
   ```

---

##  03. Адаптация под железо

1. **Мониторы и привязка воркспейсов:**
   Узнай имена своих видеовыходов через `hyprctl monitors`. По умолчанию настроено:
   * `DP-1` — основной монитор (воркспейсы `1–5`)
   * `HDMI-A-1` — второй монитор (воркспейсы `6–10`)

   При необходимости поправь имена выходов в `~/.config/hypr/hyprland.lua` и `~/.config/hypr/workspaces_bind.conf`.

2. **Видеокарта NVIDIA:**
   В начале `~/.config/hypr/hyprland.lua` проверь флаг `features.nvidia = true` (если используешь AMD/Intel — поставь `false`).

---

##  04. Горячие клавиши

`SUPER` — клавиша **Win**.

| Сочетание | Действие |
| :--- | :--- |
| `SUPER + Enter` | Терминал (Kitty) |
| `SUPER + D` | Лаунчер приложений (Noctalia) |
| `SUPER + B` | Браузер (Firefox) |
| `SUPER + E` | Файловый менеджер (Nemo) |
| `SUPER + U` | Монитор процессов (btop) |
| `SUPER + W` | Открыть / закрыть колесо обоев (Quickshell + `awww`) |
| `Alt + Shift` | Переключить язык (`us / ru`) |
| `SUPER + Q` | Закрыть активное окно |
| `SUPER + F` | Полноэкранный режим (Fullscreen) |
| `SUPER + SHIFT + V` | Плавающий режим окна (Floating) |
| `SUPER + SHIFT + T` | Изменить направление разделения окон |
| `SUPER + SHIFT + P` | Режим Pseudotile |
| `SUPER + M` / `SUPER + SHIFT + M` | Показать / отправить окно в Scratchpad (`magic`) |
| `SUPER + SHIFT + S` | Скриншот выделенной области → буфер обмена |
| `PrintScreen` | Скриншот выделенной области → буфер обмена |
| `SHIFT + PrintScreen` | Скриншот области → буфер обмена + `~/Pictures/Screenshots` |
| `SUPER + CTRL + L` | Заблокировать экран (Hyprlock) |
| `SUPER + SHIFT + ALT + E` | Выйти из Hyprland |
| `SUPER + H J K L` | Переключить фокус между окнами |
| `SUPER + SHIFT + H J K L` | Поменять окна местами |
| `SUPER + ALT + H J K L` | Переместить плавающее окно |
| `SUPER + CTRL + H J K L` | Изменить размер окна |
| `SUPER + N` / `SUPER + SHIFT + N` | Переключение по кругу между плавающими / тайловыми окнами |
| `SUPER + TAB` | Предыдущее окно |
| `ALT + TAB` | Вытащить активное окно поверх остальных |
| `SUPER + 1..5` | Рабочие столы `1–5` (основной монитор) |
| `SUPER + 6..0` | Рабочие столы `6–10` (второй монитор) |
| `SUPER + SHIFT + 1..0` | Перенести окно на нужный рабочий стол |
| `SUPER + Колесо мыши` | Листать рабочие столы |
| `SUPER + ЛКМ / ПКМ` | Перетаскивание / изменение размера окна мышью |
| `Медиа / яркость` | Громкость, плеер, подсветка экрана (работают и на экране блокировки) |




