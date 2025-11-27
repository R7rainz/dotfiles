# CodeCompanion Usage Guide

## Keybindings

### Main Actions
- **`<leader>cc`** - Open CodeCompanion Actions menu (shows all available prompts)
  - Use in normal or visual mode
  - Displays a list of built-in actions like "Explain", "Fix", "Tests", etc.

- **`<leader>ca`** - Open CodeCompanion Chat
  - Opens a new chat buffer
  - Type your question and press Enter to send
  - Chat uses GitHub Copilot GPT-4o

- **`<leader>ct`** - Toggle CodeCompanion Chat
  - Shows/hides the chat buffer
  - Keeps your conversation history

### Visual Mode
- **`ga`** - Add selection to chat (visual mode only)
  - Select code with visual mode (v, V, or Ctrl-v)
  - Press `ga` to add it to the current chat
  - Then ask questions about the selected code

## Usage Examples

### 1. Quick Code Explanation
```
1. Open file with code
2. Press <leader>cc
3. Select "Explain" from the menu
4. Get explanation in chat buffer
```

### 2. Chat with Context
```
1. Select code with visual mode (v or V)
2. Press ga to add to chat
3. Press <leader>ca to open chat
4. Type: "How can I optimize this?"
5. Press Enter
```

### 3. Inline Code Help
```
1. Press <leader>ca to open chat
2. Type your question: "How do I read a file in Lua?"
3. Get instant response from GPT-4o
```

### 4. Code Review
```
1. Select code block in visual mode
2. Press <leader>cc
3. Choose "Review" action
4. Get code review suggestions
```

## Tips
- Use `<leader>ct` to quickly toggle chat on/off
- Add multiple code selections with `ga` before asking questions
- Chat history persists until you close the buffer
- All responses use your GitHub Copilot subscription (free GPT-4o)

## Your Leader Key
Check your leader key with `:echo mapleader` (usually Space or ,)
If it's Space, then `<leader>cc` = `Space + c + c`
