## -----------------------------------------------------------------------------
## CUSTOM PALETTE: High Contrast Mocha
## -----------------------------------------------------------------------------
## Derived from Catppuccin Mocha with the following transformations:
## 1. Black Point Re anchoring: 'Crust' mapped to Pure Black (#0d0d15).
## 2. White Point Re anchoring: 'Text' mapped to Warm White (#deddda).
## 3. Lightness Remapping: All intermediate colors linearly interpolated
##    (lerped) via HLS space to fit the expanded contrast range.
## 4. Saturation Boost: +50% saturation applied to preserve color vibrancy
##    against the darker background. Neutrals (Surface/Overlay) preserve 
##    the original saturation to avoid blue tint
## 5. Rotations: Swap base with crust, make the new mantle the original crust
##    Make the new crust the original mantle
## -----------------------------------------------------------------------------


import colorsys

# --- Configuration ---
palette = {
    "Rosewater": "#f5e0dc", "Flamingo":  "#f2cdcd", "Pink":      "#f5c2e7",
    "Mauve":     "#cba6f7", "Red":       "#f38ba8", "Maroon":    "#eba0ac",
    "Peach":     "#fab387", "Yellow":    "#f9e2af", "Green":     "#a6e3a1",
    "Teal":      "#94e2d5", "Sky":       "#89dceb", "Sapphire":  "#74c7ec",
    "Blue":      "#89b4fa", "Lavender":  "#b4befe", "Text":      "#cdd6f4",
    "Subtext1":  "#bac2de", "Subtext0":  "#a6adc8", "Overlay2":  "#9399b2",
    "Overlay1":  "#7f849c", "Overlay0":  "#6c7086", "Surface2":  "#585b70",
    "Surface1":  "#45475a", "Surface0":  "#313244", "Base":      "#1e1e2e",
    "Mantle":    "#181825", "Crust":     "#11111b"
}

# Colors that should NOT receive a saturation boost to avoid becoming too blue
NEUTRALS = {
    "Subtext1", "Subtext0", "Overlay2", "Overlay1", "Overlay0", 
    "Surface2", "Surface1", "Surface0", "Base", "Mantle", "Crust"
}

TARGET_CRUST = "#000000"
TARGET_TEXT  = "#deddda"
SATURATION_BOOST = 1.5 # Increased slightly since neutrals are now safe

# --- Helper Functions ---

def hex_to_hls(hex_value):
    hex_value = hex_value.lstrip('#')
    rgb = tuple(int(hex_value[i:i+2], 16) / 255.0 for i in (0, 2, 4))
    return colorsys.rgb_to_hls(*rgb)

def hls_to_hex(h, l, s):
    l = max(0.0, min(1.0, l))
    s = max(0.0, min(1.0, s))
    rgb = colorsys.hls_to_rgb(h, l, s)
    rgb_int = tuple(int(c * 255) for c in rgb)
    return "#{:02x}{:02x}{:02x}".format(*rgb_int)

def get_rgb_int(hex_code):
    hex_code = hex_code.lstrip('#')
    return tuple(int(hex_code[i:i+2], 16) for i in (0, 2, 4))

# --- Main Logic ---

def generate_high_contrast(pal):
    new_palette = {}
    
    _, old_crust_l, _ = hex_to_hls(pal["Crust"])
    _, old_text_l, _  = hex_to_hls(pal["Text"])
    _, new_crust_l, _ = hex_to_hls(TARGET_CRUST)
    _, new_text_l, _  = hex_to_hls(TARGET_TEXT)
    
    slope = (new_text_l - new_crust_l) / (old_text_l - old_crust_l)

    for name, hex_code in pal.items():
        h, l, s = hex_to_hls(hex_code)
        
        # 1. Always apply Lightness Slope (High Contrast)
        new_l = slope * (l - old_crust_l) + new_crust_l
        
        # 2. Conditional Saturation Boost
        if name not in NEUTRALS:
            # It is a color (Red, Blue, etc) -> Boost it
            new_s = s * SATURATION_BOOST
        else:
            # It is a neutral (Surface, Overlay) -> Keep original saturation
            new_s = s 

        # 3. Anchors and Output
        if name == "Crust":
            new_palette[name] = TARGET_CRUST
        elif name == "Text":
            new_palette[name] = TARGET_TEXT
        else:
            new_palette[name] = hls_to_hex(h, new_l, new_s)
            
    return new_palette

# --- Output Generation ---

new_pal = generate_high_contrast(palette)

# Rotations
# 1. Swap crust and base
new_pal["Base"], new_pal["Crust"] = new_pal["Crust"], new_pal["Base"]
# 2. Make the new mantle the original crust
new_pal["Mantle"] = palette["Crust"]
# 3. Make the new crust the original mantle
new_pal["Crust"] = palette["Mantle"]

print("\n--- New Palette Code ---\n")
for key, value in new_pal.items():
    print(f'{key.lower():<12} = "{value}",')

print("\n--- Visual Diff (Old vs New) ---\n")

for key in palette:
    old_hex = palette[key]
    new_hex = new_pal[key]
    
    or_, og, ob = get_rgb_int(old_hex)
    nr, ng, nb = get_rgb_int(new_hex)
    
    block_char = "      " 
    old_block = f"\033[48;2;{or_};{og};{ob}m{block_char}\033[0m"
    new_block = f"\033[48;2;{nr};{ng};{nb}m{block_char}\033[0m"
    
    print(f"{old_block}{new_block}  {key}")

