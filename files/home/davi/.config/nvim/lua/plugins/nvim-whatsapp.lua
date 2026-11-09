-- WhatsApp in Neovim (my own plugin, loaded from its local folder)

return {
    dir = "~/Documents/projects/nvim-whatsapp",
    dependencies = { "MunifTanjim/nui.nvim" },
    build = "make build",
    cmd = "WhatsApp",
    keys = {
        { "<leader>mm", "<cmd>WhatsApp<CR>", desc = "[m]essages: [m]ain list (WhatsApp)" },
        { "<leader>md", "<cmd>WhatsApp drafts<CR>", desc = "[m]essages: [d]rafts (WhatsApp)" },
        -- Find a chat from anywhere (inside WhatsApp buffers <leader>ff does the same).
        {
            "<leader>fw",
            function()
                require("whatsapp").actions.find_chat()
            end,
            desc = "[f]ind [w]hatsApp chat",
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

            -- Voice notes as text, on this machine (<leader>mt in a chat; assistants: transcribe_audio).
            transcribe = {
                model = "~/.local/share/whisper/ggml-large-v3-turbo-q5_0.bin",
                language = "pt",
            },

            -- The plugin shows only name, tick, preview and time by default; these are opted in.
            chat_list = {
                columns = {
                    { "name", min = 8, max = 0.4 },
                    { "sender" },
                    { "tick" },
                    { "preview", width = "fill" },
                    -- "@" when you were mentioned (peach text), then the unread count as a badge
                    -- like the phone's (filled by its highlight below; `pad` puts a space inside
                    -- each side): " 3 " (sapphire), or an empty dot in its place for a chat marked
                    -- unread by hand.
                    { "mention" },
                    { "unread", pad = 1, align = "right" },
                    -- "/" for a muted chat (symbols.muted), dim.
                    { "muted", over_rows = true },
                    -- Keep their own dim look on unread rows, not even bold (over_rows).
                    { "time", align = "right", over_rows = true },
                },
                -- An unread chat's whole row in its colour (except the time); the badges keep
                -- their own.
                strong_rows = { "mention", "unread", "marked_unread" },
            },

            -- Opt-in: nothing below happens unless set here (every option: docs/options.md).
            -- Only system pop-ups (notify-send) for new messages; no in-Neovim notifications
            -- (`notify`, off by default).
            desktop_notifications = true,
            presence = "auto", -- appear online while a WhatsApp buffer is in front
            update_warning_days = 14, -- warn when the WhatsApp library is older than this (no request is made)
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
                deleted_text = true, -- keep showing what a deleted message said, marked "deleted"
                stickers = true, -- draw stickers as pictures (kitty), downloading them automatically
                sticker_rows = 10, -- how many lines tall a sticker is (its width follows its shape)
                animate_stickers = "all", -- animated stickers move: "all", "cursor" (only the one under it), or false
                quote_indent = 2, -- spaces before a reply's "> Ana: ..." line
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
                    new_list = "o", -- create a list of your own (its name and chats in a buffer; :w creates it)
                    edit_list = "cc", -- edit the list: its name and chats (:w applies)
                    delete_list = "dd", -- delete the list of your own (asks first; its chats stay)
                    find_chat = "<leader>ff", -- find a chat (picker)
                    search = "<leader>fg", -- search messages in all chats (picker)
                },
                gallery = { -- whatsapp://media/<chat id> (a chat's media, docs and links).
                    open = "<CR>", -- go to the message in the chat
                    open_media = "gx", -- open the file (downloading it first), or the link
                    save_media = "<leader>ms", -- save the file to your downloads folder
                    next_section = "]]", -- next section: media, docs, links (wraps around)
                    prev_section = "[[", -- previous section
                    chat = "-", -- up: the chat
                },
                info = { -- whatsapp://info/<chat id> (a contact's or group's info).
                    open = "<CR>", -- act on what is under the cursor: the photo or a link opens, a group or member its chat
                    open_media = "gx", -- open the profile photo (downloading it), or the link on the line
                    save_media = "<leader>ms", -- save the profile photo to your downloads folder
                    chat = "-", -- up: the chat
                },
                list_edit = { -- whatsapp://lists/<id> (a list's name and chats; :w applies).
                    add_chats = "<leader>ma", -- add chats chosen in the picker, under the cursor
                },
                chats = { -- whatsapp://chats/<list>.
                    open = { "<CR>", "gf" }, -- open the chat
                    open_split = "<C-w>f", -- open the chat in a split
                    open_tab = "<C-w>gf", -- open the chat in a new tab
                    lists = "-", -- up: the index of lists
                    mark_read = "<leader>mx", -- mark the chat read (in Visual mode: every selected chat)
                    mark_unread = "<leader>mu", -- mark the chat unread (in Visual mode: every selected chat)
                    pin = "<leader>mp", -- pin or unpin the chat (WhatsApp allows 3 pinned chats)
                    archive = "<leader>ma", -- archive or unarchive the chat (in Visual mode: every selected chat)
                    mute = "<leader>mz", -- mute (asks for how long) or unmute (in Visual mode: every selected chat)
                    delete = "dd", -- clear, delete or (a group) leave the chat; asks which (Visual: every selected chat)
                    add_to_list = "<leader>ml", -- put the chat in a list, or take it out (Visual mode: every selected)
                    edit_list = "cc", -- in a WhatsApp list: edit it (its name and chats; :w applies)
                    info = "<leader>mi", -- the chat's info: about, photo, members, groups in common
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
                    mark_read = "<leader>mx", -- mark read up to the message under the cursor
                    chat_list = "-", -- up: the chat list this chat was opened from
                    find_chat = "<leader>ff", -- find a chat (picker)
                    search = "<leader>fg", -- search messages in all chats (picker)
                    search_chat = "<leader>f/", -- search this chat's whole history (picker)
                    transcribe = "<leader>mt", -- the voice note's words under it; nobody is told
                    details = "K", -- details of the message: dates, status, read by, media, poll voters
                    vote = "<leader>mv", -- vote for the poll option under the cursor (again: take it back)
                    react = "<leader>mr", -- react (emoji picker); on several selected messages in Visual mode
                    forward = "<leader>mf", -- forward to a chat (picker); several selected messages in Visual mode
                    pin = "<leader>mp", -- pin the message in the chat (asks for how long); on a pinned one: unpin
                    goto_pinned = "gP", -- go to the pinned messages in turn (<C-t> back)
                    delete = "dd", -- delete the message: for everyone (yours, recent) or for you (asks)
                    delete_selection = "d", -- Visual mode: delete the selected messages (asks how)
                    star = "<leader>m*", -- star the message, or unstar it (Visual mode: every selected one)
                    gallery = "<leader>fm", -- the chat's media, docs and links (whatsapp://media/<id>)
                    info = "<leader>mi", -- the chat's info: about, photo, members, groups in common (whatsapp://info/<id>)
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
                    save_media = "<leader>ms", -- save the media to your downloads folder (HD when there is one)
                    back = "<C-t>", -- back to where you were before the last jump
                    retry = "<leader>mR", -- send your failed message again
                    inner_message = "im", -- text object: message body
                    around_message = "am", -- text object: whole message
                },
                compose = { -- whatsapp://compose/<id>. Normal mode only: Insert mode is for text.
                    send = "<CR>", -- send (:w also sends)
                    cancel_reply = "<C-c>", -- end the mode (edit, poll, files), else drop the reply; the text stays
                    attach = "<leader>ma", -- attach files (mini.files): "+ path" lines on top of the message; :w sends
                    paste = "p", -- p that also attaches a copied image or copied files; text is put as usual
                    record = "<leader>mv", -- record a voice note; again: pause / resume (:w reviews, <C-c> discards)
                    react = "<leader>mr", -- react to the message being replied to: a line in the input; :w sends
                    sticker = "<leader>ms", -- sticker tray in the input (w/b move, <CR> sends, <C-c> or this key back)
                    play = "gx", -- play the file (+ line) under the cursor, or the recording so far while paused
                    find_chat = "<leader>ff", -- find a chat (picker), as in chats and lists
                    search = "<leader>fg", -- search messages in all chats (picker)
                    -- The input's tabs (its drafts: yours, an assistant's, an edit...). :WhatsApp draft {n} too.
                    next_tab = "gt", -- next tab; with a count, that tab: 2gt
                    prev_tab = "gT", -- previous tab
                    new_tab = "<C-t>", -- a new, empty tab, to write another draft
                    close_tab = "gX", -- close the tab shown; its text goes to the " register
                },
                forward_picker = { -- the chat picker of forwarding (<leader>mf): mark chats with <C-x>.
                    send_to_marked = "<C-CR>", -- forward to every marked chat (<CR>: the one under the cursor)
                },
                attach_files = { -- mini.files, while choosing files to attach (<leader>ma).
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
                -- Unread in sapphire; mentions (more urgent) in peach, the one warm colour here.
                -- Their whole rows take the colour (chat_list.strong_rows), and the unread badge is
                -- filled: easier to spot than text. Mentions everywhere are coloured text, never a
                -- fill. Muted chats are dimmed only while nothing in
                -- them is unread (the unread colours outrank muted); their badges look like any
                -- other's. The preview has no colour of its own: the same as the name.
                WhatsAppChatsRowMention = { fg = c.peach, bold = true },
                WhatsAppChatsRowUnread = { fg = c.sapphire, bold = true },
                WhatsAppChatsRowMarkedUnread = { fg = c.sapphire },
                -- WhatsAppChatsRowPinned = { fg = c.red },
                WhatsAppChatsRowMuted = { fg = c.overlay0 },
                WhatsAppChatsUnread = { fg = c.base, bg = c.sapphire, bold = true },
                WhatsAppChatsUnreadMuted = { link = "WhatsAppChatsUnread" },
                WhatsAppChatsMention = { fg = c.peach, bold = true },
                WhatsAppChatsMuted = { fg = c.overlay1 },
                WhatsAppChatsMarkedUnread = { fg = c.sapphire, bg = c.sapphire }, -- its "o" hidden: an empty dot
                WhatsAppChatsPinned = { fg = c.red },
                WhatsAppChatsTyping = { fg = c.green, italic = true },
                WhatsAppChatsDraft = { fg = c.green }, -- "Draft:" before a chat's draft, as the apps
                WhatsAppChatsTime = { fg = c.overlay1 },

                -- Chat info (gK): the name in the accent, labels dimmed, members and groups in green.
                WhatsAppInfoName = { fg = c.sapphire, bold = true },
                WhatsAppInfoLabel = { fg = c.overlay1 },
                WhatsAppInfoMember = { fg = c.green },

                -- Chat screen: you in the accent, the other person in green; in groups, each
                -- person gets one of six colours (none of them the accent, nor peach, which is
                -- kept for what matters: mentions of you).
                WhatsAppMsgSenderMe = { fg = c.sapphire, bold = true },
                WhatsAppMsgSender = { fg = c.green, bold = true },
                WhatsAppMsgSender1 = { fg = c.green, bold = true },
                WhatsAppMsgSender2 = { fg = c.lavender, bold = true },
                WhatsAppMsgSender3 = { fg = c.mauve, bold = true },
                WhatsAppMsgSender4 = { fg = c.pink, bold = true },
                WhatsAppMsgSender5 = { fg = c.yellow, bold = true },
                WhatsAppMsgSender6 = { fg = c.teal, bold = true },
                -- The part of the message under the cursor (name, quote or text).
                WhatsAppMsgCurrent = { bg = c.surface0 },
                -- Metadata, dimmed: time, marks, ticks (read ones in green, WhatsApp's colour:
                -- sapphire now means unread in the chat list).
                WhatsAppMsgTime = { fg = c.overlay0 },
                WhatsAppMsgEdited = { fg = c.overlay0, italic = true },
                WhatsAppMsgPinned = { fg = c.red }, -- "*" before the time of a pinned message, like pinned chats
                WhatsAppMsgStarred = { fg = c.yellow }, -- "+" before the time of a message you starred
                WhatsAppMsgForwarded = { fg = c.overlay0, italic = true },
                WhatsAppTickPending = { fg = c.overlay0 },
                WhatsAppTickSent = { fg = c.overlay1 },
                WhatsAppTickDelivered = { fg = c.overlay1 },
                WhatsAppTickRead = { fg = c.green },
                WhatsAppTickFailed = { fg = c.red, bold = true },
                -- Separators and status rows.
                WhatsAppMsgDate = { fg = c.overlay1 },
                WhatsAppMsgStickyDate = { fg = c.overlay0, italic = true },
                WhatsAppMsgUnreadSep = { fg = c.sapphire, bold = true },
                WhatsAppMsgStatusLine = { fg = c.overlay0, italic = true },
                WhatsAppMsgTyping = { fg = c.green, italic = true },
                -- Reply quotes: an accent ">" and a muted line, nothing bold.
                WhatsAppMsgQuoteBar = { fg = c.sapphire },
                WhatsAppMsgQuoteSender = { fg = c.subtext1 },
                WhatsAppMsgQuoteText = { fg = c.subtext0, italic = true },
                -- Placeholders and notices.
                WhatsAppMsgMedia = { fg = c.teal },
                -- A voice note you have not played yet: its details in the accent, as the apps' dot.
                WhatsAppMsgUnplayed = { fg = c.sapphire, bold = true },
                WhatsAppMsgDeleted = { fg = c.overlay0, italic = true },
                -- What a deleted message said (chat.deleted_text): struck through, still readable.
                WhatsAppMsgDeletedText = { fg = c.subtext0, strikethrough = true },
                WhatsAppMsgSystem = { fg = c.overlay1, italic = true },
                WhatsAppMsgUnsupported = { fg = c.overlay0, italic = true },
                WhatsAppMsgReaction = { fg = c.subtext1 },
                WhatsAppMsgReactionMine = { fg = c.sapphire },
                -- Mentions: coloured text, never a fill; yours in peach and bold, as in the chat
                -- list. WhatsApp formatting (*bold*, _italic_...) is left unstyled on purpose:
                -- messages show exactly what was typed.
                WhatsAppMsgMention = { fg = c.sapphire },
                WhatsAppMsgMentionMe = { fg = c.peach, bold = true },

                -- Attaching files in the input: the "+ path" line in the accent, what it goes as
                -- dimmed, a file that cannot be sent in red.
                WhatsAppComposeFile = { fg = c.sapphire },
                WhatsAppComposeFileInfo = { fg = c.overlay1 },
                WhatsAppComposeFileMissing = { fg = c.red, bold = true },
                -- "recording 0:12" while recording a voice note.
                WhatsAppComposeRecording = { fg = c.red, bold = true },
            },

            -- No bars in the sign column.
            symbols = { bar_mine = "", bar_theirs = "", muted = "\u{f075f}", },
        }
    end,
}
