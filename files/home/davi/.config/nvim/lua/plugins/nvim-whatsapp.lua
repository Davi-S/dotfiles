return {
    dir = "~/Documents/projects/nvim-whatsapp",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = "make build",
    cmd = "WhatsApp",
    keys = {
        { "<leader>mm", "<cmd>WhatsApp<cr>", desc = "WhatsApp" },
        -- Find a chat from anywhere (inside WhatsApp buffers <leader>ff does the same).
        {
            "<leader>fw",
            function()
                require("whatsapp").actions.find_chat()
            end,
            desc = "Find WhatsApp chat",
        },
    },
    -- A function, so the colours come from catppuccin's palette (same flavour as the colorscheme).
    -- Every option: ~/Documents/projects/nvim-whatsapp/docs/options.md, or :WhatsApp config
    opts = function()
        local c = require("catppuccin.palettes").get_palette("mocha")
        return {
            data_dir = "~/.local/share/nvim-whatsapp/dev",
            -- Several Neovims use this account at once: the first to open WhatsApp owns the backend
            -- (it stops when that Neovim closes); the others connect to it.
            shared = true,

            -- The plugin shows only name, tick, preview and time by default; these are opted in.
            chat_list = {
                columns = {
                    { "name", min = 8, max = 0.4 },
                    { "sender" },
                    { "tick" },
                    { "preview", width = "fill" },
                    { "time", align = "right" },
                },
            },

            -- Opt-in: nothing below happens unless set here (every option: docs/options.md).
            -- Only system pop-ups (notify-send) for new messages; no in-Neovim notifications
            -- (`notify`, off by default).
            desktop_notifications = true,
            presence = "auto", -- appear online while a WhatsApp buffer is in front
            compose = {
                send_typing = true, -- the other side sees you typing
                always_visible = true, -- the input stays open under every chat window
                reply_indicator = false, -- the window bar says "Replying to Ana: ..." instead
                height = 8, -- lines of the input window
                sticker_rows = 8, -- how tall stickers are in the sticker tray (gs); the input grows to fit
            },
            chat = {
                jump_to_sent = true, -- after sending, go to the newest message
                waveform = true, -- draw voice notes' waveform (block characters)
                stickers = true, -- draw stickers as pictures (kitty), downloading them automatically
                sticker_rows = 10, -- how many lines tall a sticker is (its width follows its shape)
                animate_stickers = "all", -- animated stickers move: "all", "cursor" (only the one under it), or false
            },
            media = {
                speeds = { 1, 1.5, 2 }, -- playback speeds, stepped with <C-a> / <C-x> in a chat
                seek_s = 5, -- seconds > and < move the audio playing (3> moves three steps)
            },

            -- WhatsApp's own statusline in its windows: mode, title ("Ana (online)", "Replying to
            -- Ana: ...") and WhatsApp's state. Your mini.statusline stays everywhere else.
            statusline = true,

            -- Window options for every WhatsApp window (lists, chats, compose, login, config).
            windows = {
                all = { spell = false },
            },

            -- No key is mapped by default. These are all the suggested keys; delete or change any.
            keys = {
                lists = { -- whatsapp://lists (the index of chat lists).
                    open = { "<CR>", "gf" }, -- open the list
                    open_split = "<C-w>f", -- open the list in a split
                    open_tab = "<C-w>gf", -- open the list in a new tab
                    find_chat = "<leader>ff", -- find a chat (picker)
                    search = "<leader>fg", -- search messages in all chats (picker)
                },
                chats = { -- whatsapp://chats/<list>.
                    open = { "<CR>", "gf" }, -- open the chat
                    open_split = "<C-w>f", -- open the chat in a split
                    open_tab = "<C-w>gf", -- open the chat in a new tab
                    lists = "-", -- up: the index of lists
                    mark_read = "<C-r>", -- mark the chat read (in Visual mode: every selected chat)
                    mark_unread = "gu", -- mark the chat unread (in Visual mode: every selected chat)
                    pin = "gp", -- pin or unpin the chat (WhatsApp allows 3 pinned chats)
                    archive = "ga", -- archive or unarchive the chat (in Visual mode: every selected chat)
                    mute = "gm", -- mute (asks for how long) or unmute (in Visual mode: every selected chat)
                    find_chat = "<leader>ff", -- find a chat (picker)
                    search = "<leader>fg", -- search messages in all chats (picker)
                },
                chat = { -- whatsapp://chat/<id>.
                    compose = { "i", "a", "o" }, -- write a message
                    reply = "r", -- reply to the message under the cursor
                    next_message = "]m", -- next message (takes a count)
                    prev_message = "[m", -- previous message
                    first_unread = "]u", -- first unread message
                    next_sender = "]]", -- next change of sender (takes a count)
                    prev_sender = "[[", -- previous change of sender
                    next_day = "]d", -- first message of the next day
                    prev_day = "[d", -- first message of the previous day
                    next_notable = "]r", -- next message with reactions or mentioning you
                    prev_notable = "[r", -- previous message with reactions or mentioning you
                    mark_read = "<C-r>", -- mark read up to the message under the cursor
                    chat_list = "-", -- up: the chat list this chat was opened from
                    find_chat = "<leader>ff", -- find a chat (picker)
                    search = "<leader>fg", -- search messages in all chats (picker)
                    search_chat = "g/", -- search this chat's whole history (picker)
                    details = "K", -- details of the message: dates, status, read by, media, poll voters
                    vote = "gv", -- vote for the poll option under the cursor (again: take it back)
                    react = "R", -- react (emoji picker); on several selected messages in Visual mode
                    forward = "gF", -- forward to a chat (picker); several selected messages in Visual mode
                    pin = "gp", -- pin the message in the chat (asks for how long); on a pinned one: unpin
                    goto_pinned = "gP", -- go to the pinned messages in turn (<C-t> back)
                    delete = "dd", -- delete your message for everyone (asks first)
                    delete_selection = "d", -- Visual mode: delete the selected messages of yours
                    edit = "cc", -- edit your message (in the compose window; :w saves)
                    goto_quote = { "gd", "<C-]>" }, -- jump to the message this one replies to
                    next_reply = "gR", -- go to each reply of this message in turn (wraps around; <C-t> back)
                    thread_down = "gD", -- go down the conversation: this message's reply, then its reply...
                    open = "<CR>", -- act on what is under the cursor: vote (poll option), jump (quote line), open (media)
                    open_media = "gx", -- open the media (download first if needed); plays audio, gx again stops
                    open_media_hd = "gX", -- open the HD copy of a photo or video
                    speed_up = "<C-a>", -- play audio faster (next of media.speeds), also while playing
                    speed_down = "<C-x>", -- play audio slower
                    seek_forward = ">", -- move the audio playing media.seek_s seconds forward (takes a count)
                    seek_back = "<", -- move the audio playing media.seek_s seconds back
                    save_media = "gs", -- save the media to your downloads folder (HD when there is one)
                    back = "<C-t>", -- back to where you were before the last jump
                    retry = "gr", -- send your failed message again
                    inner_message = "im", -- text object: message body
                    around_message = "am", -- text object: whole message
                },
                compose = { -- whatsapp://compose/<id>. Normal mode only: Insert mode is for text.
                    send = "<CR>", -- send (:w also sends)
                    cancel_reply = "<C-c>", -- end the mode (edit, poll, files), else drop the reply; the text stays
                    attach = "<C-a>", -- attach files (mini.files): "+ path" lines on top of the message; :w sends
                    paste = "p", -- p that also attaches a copied image or copied files; text is put as usual
                    record = "gV", -- record a voice note; again: pause / resume (:w reviews, <C-c> discards)
                    sticker = "gs", -- sticker tray in the input (w/b move, <CR> sends, <C-c> or gs back)
                    play = "gx", -- play the file (+ line) under the cursor, or the recording so far while paused
                    find_chat = "<leader>ff", -- find a chat (picker), as in chats and lists
                    search = "<leader>fg", -- search messages in all chats (picker)
                },
                forward_picker = { -- the chat picker of forwarding (gF): mark chats with <C-x>.
                    send_to_marked = "<C-CR>", -- forward to every marked chat (<CR>: the one under the cursor)
                },
                attach_files = { -- mini.files, while choosing files to attach (<C-a>).
                    choose = "<CR>", -- attach the file (on a directory: open it); in Visual mode, every selected file
                },
                login = { -- whatsapp://login.
                    retry = "r", -- try linking again
                },
            },

            -- Colours: sapphire is the accent (as in the rest of the desktop), green the secondary
            -- colour (WhatsApp's own), red for pinned chats; metadata is dimmed.
            highlights = {
                -- The plugin's statusline (option `statusline`): mode in the accent, the title in
                -- sapphire on a dark line, WhatsApp's state in green.
                WhatsAppStatus = { fg = c.text, bg = c.mantle },
                WhatsAppStatusNC = { fg = c.overlay1, bg = c.mantle },
                WhatsAppStatusMode = { fg = c.base, bg = c.sapphire, bold = true },
                WhatsAppStatusTitle = { fg = c.sapphire, bg = c.mantle, bold = true },
                WhatsAppStatusInfo = { fg = c.base, bg = c.green, bold = true },

                -- Chat lists. When two row states set the text colour, the more urgent wins:
                -- mention > unread > marked unread > pinned > muted.
                WhatsAppChatsRowMention = { fg = c.sapphire },
                WhatsAppChatsRowUnread = { bold = true },
                WhatsAppChatsRowMarkedUnread = { bold = true },
                WhatsAppChatsRowPinned = { fg = c.red },
                WhatsAppChatsRowMuted = { fg = c.overlay0 },
                WhatsAppChatsUnread = { fg = c.sapphire, bold = true },
                WhatsAppChatsUnreadMuted = { fg = c.overlay1 },
                WhatsAppChatsMention = { fg = c.sapphire, bold = true },
                WhatsAppChatsMarkedUnread = { fg = c.sapphire },
                WhatsAppChatsPinned = { fg = c.red },
                WhatsAppChatsPreview = { fg = c.subtext0 },
                WhatsAppChatsPreviewSender = { fg = c.green },
                WhatsAppChatsTyping = { fg = c.green, italic = true },
                WhatsAppChatsTime = { fg = c.overlay1 },

                -- Chat screen: you in the accent, the other person in green; in groups, each
                -- person gets one of six colours (none of them the accent).
                WhatsAppMsgSenderMe = { fg = c.sapphire, bold = true },
                WhatsAppMsgSender = { fg = c.green, bold = true },
                WhatsAppMsgSender1 = { fg = c.green, bold = true },
                WhatsAppMsgSender2 = { fg = c.peach, bold = true },
                WhatsAppMsgSender3 = { fg = c.mauve, bold = true },
                WhatsAppMsgSender4 = { fg = c.pink, bold = true },
                WhatsAppMsgSender5 = { fg = c.yellow, bold = true },
                WhatsAppMsgSender6 = { fg = c.teal, bold = true },
                -- The part of the message under the cursor (name, quote or text).
                WhatsAppMsgCurrent = { bg = c.surface0 },
                -- Metadata, dimmed: time, marks, ticks (read ones in the accent).
                WhatsAppMsgTime = { fg = c.overlay0 },
                WhatsAppMsgEdited = { fg = c.overlay0, italic = true },
                WhatsAppMsgPinned = { fg = c.red }, -- "*" before the time of a pinned message, like pinned chats
                WhatsAppMsgForwarded = { fg = c.overlay0, italic = true },
                WhatsAppTickPending = { fg = c.overlay0 },
                WhatsAppTickSent = { fg = c.overlay1 },
                WhatsAppTickDelivered = { fg = c.overlay1 },
                WhatsAppTickRead = { fg = c.sapphire },
                WhatsAppTickFailed = { fg = c.red, bold = true },
                -- Separators and status rows.
                WhatsAppMsgDate = { fg = c.overlay1 },
                WhatsAppMsgUnreadSep = { fg = c.sapphire, bold = true },
                WhatsAppMsgStatusLine = { fg = c.overlay0, italic = true },
                WhatsAppMsgTyping = { fg = c.green, italic = true },
                -- Reply quotes: an accent ">" and a muted line.
                WhatsAppMsgQuoteBar = { fg = c.sapphire, bold = true },
                WhatsAppMsgQuoteSender = { fg = c.subtext1, bold = true },
                WhatsAppMsgQuoteText = { fg = c.subtext0, italic = true },
                -- Placeholders and notices.
                WhatsAppMsgMedia = { fg = c.teal },
                -- A voice note you have not played yet: its details in the accent, as the apps' dot.
                WhatsAppMsgUnplayed = { fg = c.sapphire, bold = true },
                WhatsAppMsgDeleted = { fg = c.overlay0, italic = true },
                WhatsAppMsgSystem = { fg = c.overlay1, italic = true },
                WhatsAppMsgUnsupported = { fg = c.overlay0, italic = true },
                WhatsAppMsgReaction = { fg = c.subtext1 },
                WhatsAppMsgReactionMine = { fg = c.sapphire },
                -- Mentions (yours as a sapphire badge). WhatsApp formatting (*bold*, _italic_...)
                -- is left unstyled on purpose: messages show exactly what was typed.
                WhatsAppMsgMention = { fg = c.sapphire },
                WhatsAppMsgMentionMe = { fg = c.base, bg = c.sapphire, bold = true },

                -- Attaching files in the input: the "+ path" line in the accent, what it goes as
                -- dimmed, a file that cannot be sent in red.
                WhatsAppComposeFile = { fg = c.sapphire },
                WhatsAppComposeFileInfo = { fg = c.overlay1 },
                WhatsAppComposeFileMissing = { fg = c.red, bold = true },
                -- "recording 0:12" while recording a voice note.
                WhatsAppComposeRecording = { fg = c.red, bold = true },
            },

            -- No bars in the sign column.
            symbols = { bar_mine = "", bar_theirs = "" },
        }
    end,
}
