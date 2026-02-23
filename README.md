# dotfiles

開発環境の設定ファイル群。Kanagawa-Dragon テーマで統一。

## セットアップ

### 1. Homebrew でツールをインストール

```sh
brew install neovim tmux fzf ripgrep
```

### 2. Node.js (coc.nvim に必要)

```sh
curl https://get.volta.sh | bash
volta install node
```

### 3. Nerd Font のインストール (任意)

vim-devicons のアイコン表示に必要。

```sh
brew install --cask font-hack-nerd-font
```

インストール後、ターミナルのフォント設定を Nerd Font に変更する。

### 4. シンボリックリンクを作成

```sh
DOTFILES=~/workspace/dotfiles

ln -sf $DOTFILES/.zshrc ~/.zshrc
ln -sf $DOTFILES/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim
ln -sf $DOTFILES/init.vim ~/.config/nvim/init.vim
ln -sf $DOTFILES/coc-settings.json ~/.config/nvim/coc-settings.json
```

### 5. シェルを再起動

```sh
exec zsh
```

Zinit と Zsh プラグインは初回起動時に自動インストールされる。

### 6. Neovim プラグインのインストール

[vim-plug](https://github.com/junegunn/vim-plug) を入れてからプラグインをインストールする。

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
```

## 構成

| ファイル | 配置先 | 内容 |
|---|---|---|
| `.zshrc` | `~/.zshrc` | Zsh (Zinit + fzf + vi-mode) |
| `.tmux.conf` | `~/.tmux.conf` | tmux (Kanagawa-Dragon テーマ + Vim風操作) |
| `init.vim` | `~/.config/nvim/init.vim` | Neovim (vim-plug + coc.nvim + fzf) |
| `coc-settings.json` | `~/.config/nvim/coc-settings.json` | coc.nvim の Git サイン設定 |

## Zsh

**プラグインマネージャ**: [Zinit](https://github.com/zdharma-continuum/zinit)

**プラグイン**:
- `zsh-autosuggestions` - コマンド候補の自動表示
- `zsh-syntax-highlighting` - シンタックスハイライト
- `zsh-vi-mode` - Vi キーバインド

**エイリアス**:
| コマンド | 展開先 |
|---|---|
| `vim` | `nvim` |
| `ll` | `ls -la` |

**fzf キーバインド**:
| キー | 機能 |
|---|---|
| `Ctrl+R` | コマンド履歴検索 |
| `Ctrl+T` | ファイル検索 |
| `Ctrl+G` | ディレクトリ移動 |

**Vi ノーマルモード (Esc で切替)**:
| キー | 機能 |
|---|---|
| `H` | 前のWORDへ (空白区切り) |
| `L` | 次のWORDへ (空白区切り) |
| `Ctrl+h` | 1単語戻る |
| `Ctrl+l` | 1単語進む |

## tmux

**prefix**: `Ctrl+a`

### 主要キーバインド

| キー | 機能 |
|---|---|
| `prefix + h/j/k/l` | ペイン移動 |
| `prefix + Ctrl+h/j/k/l` | ペインリサイズ |
| `prefix + H/J/K/L` | ペイン入れ替え |
| `prefix + ←/→` | ウィンドウ移動 |
| `prefix + n` | 新規ウィンドウ |
| `prefix + r` | ウィンドウ名変更 |
| `prefix + Ctrl+r` | セッション名変更 |
| `prefix + s` | セッション一覧 |
| `prefix + -` | 水平分割 |
| `prefix + \` | 垂直分割 |
| `prefix + Backspace` | ペイン削除 |

コピーモードは Vi キーバインド (`v` で選択開始、`y` でヤンク)。

## Neovim

**Leader**: `Space`

**プラグイン**:
- [kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) - カラースキーム
- [lightline.vim](https://github.com/itchyny/lightline.vim) - ステータスライン
- [coc.nvim](https://github.com/neoclide/coc.nvim) - LSP / 補完
- [vim-fugitive](https://github.com/tpope/vim-fugitive) - Git 操作
- [vim-commentary](https://github.com/tpope/vim-commentary) - コメントトグル
- [vim-surround](https://github.com/tpope/vim-surround) - 囲み文字操作
- [fzf.vim](https://github.com/junegunn/fzf.vim) - ファジーファインダー
- [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) - Markdown プレビュー

### 移動

| | 左 | 下 | 上 | 右 |
|---|---|---|---|---|
| **そのまま** | `h` 1文字 | `j` 1行 | `k` 1行 | `l` 1文字 |
| **Ctrl** | `Ctrl+h` 1単語戻る | `Ctrl+j` スクロール↓ | `Ctrl+k` スクロール↑ | `Ctrl+l` 1単語進む |
| **Shift** | `H` 行頭 | `J` ファイル末尾 | `K` ファイル先頭 | `L` 行末 |

### 検索・置換

| キー | 機能 |
|---|---|
| `Ctrl+f` | ファイル内検索 |
| `F` | fzf でファイル内検索 (部分一致) |
| `Ctrl+s` | Ripgrep でプロジェクト横断検索 |
| `Ctrl+o` | Git ファイル名検索 |
| `Tab` / `Shift+Tab` | 検索マッチの次 / 前 |
| `Esc` | 検索ハイライト解除 |
| `s` | 確認付き置換 (カーソル下の単語) |
| `S` | 一括置換 (カーソル下の単語) |

ビジュアルモードでは選択テキストが置換対象になる。`s` は選択範囲内、`S` はファイル全体で確認付き置換。

### LSP (coc.nvim)

| キー | 機能 |
|---|---|
| `gd` | 定義へジャンプ |
| `gy` | 型定義へジャンプ |
| `gi` | 実装へジャンプ |
| `gr` | 参照一覧 |

### その他

| キー | 機能 |
|---|---|
| `Ctrl+p` (markdown) | Markdown プレビュー |
