# autow.nvim (auto + `:w` command)
nvim向けプラグイン: ファイルの自動保存

## 機能
- 入力モードを抜けたタイミングで開いているファイルの自動保存
- 対象とするファイルタイプを指定可能
- 特定ファイル名では自動保存しない設定が可能
- ON/OFFのトグル機能

## 特徴
- 100％Lua実装
- 軽量

---

## 使い方

### 1. インストール

お好みのプラグインマネージャーを使用して `autow.nvim` をインストールします。

**packer.nvim の場合:**

```lua
use 'uhsog/autow.nvim'
```

**lazy.nvim の場合:**

```lua
{ 'uhsog/autow.nvim',
  config = function()
    require('autow').setup()
  end
},
```

### 2. 設定 (init.lua または init.vim)

Neovimの設定ファイル（通常 `~/.config/nvim/init.lua` または `~/.config/nvim/init.vim`）に、`require('autow').setup()` を追加してプラグインを有効にします。

**例 (init.lua):**

```lua
-- デフォルト設定で有効化
require('autow').setup()

-- カスタム設定の例
-- require('autow').setup({
--     enabled = true, -- 初期状態で有効にするか (デフォルト: true)
--     filetypes = { "lua", "python", "javascript" }, -- これらのファイルタイプのみ自動保存 (空のテーブルは全てを対象)
--     exclude_filenames = { "COMMIT_EDITMSG", "*.git/COMMIT_EDITMSG", "**/tmp/*" }, -- これらのファイル名を除外
-- })
```

### 3. 使用方法

*   Neovimを開き、ファイルを編集します。
*   Insertモードを終了する（例: `Esc`キーを押してNormalモードに戻る）と、変更が自動的に保存されます。

### 4. ON/OFFの切り替え

*   コマンドラインモードで `:AutowToggle` を実行すると、自動保存機能のON/OFFが切り替わります。
*   現在の状態はメッセージで表示されます。
