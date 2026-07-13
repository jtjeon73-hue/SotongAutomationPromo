from PIL import Image
import os

src = Image.open("assets/images/sotongware_logo_source.png").convert("RGBA")
w, h = src.size
pixels = src.load()

out = Image.new("RGBA", (w, h))
out_px = out.load()
for y in range(h):
    for x in range(w):
        r, g, b, a = pixels[x, y]
        if r > 230 and g > 230 and b > 230:
            out_px[x, y] = (r, g, b, 0)
        elif abs(r - g) < 12 and abs(g - b) < 12 and r > 210:
            out_px[x, y] = (r, g, b, 0)
        else:
            out_px[x, y] = (r, g, b, a)


def trim(im, pad=8):
    bbox = im.getbbox()
    if not bbox:
        return im
    l, t, r, b = bbox
    l = max(0, l - pad)
    t = max(0, t - pad)
    r = min(im.width, r + pad)
    b = min(im.height, b + pad)
    return im.crop((l, t, r, b))


full = trim(out, pad=6)
full.save("assets/images/sotongware_logo_full.png")
print("full", full.size)

alpha = [
    any(full.getpixel((x, y))[3] > 20 for x in range(full.width))
    for y in range(full.height)
]
rows = []
in_content = False
start = None
for y, has in enumerate(alpha):
    if has and not in_content:
        in_content = True
        start = y
    elif not has and in_content:
        rows.append((start, y - 1))
        in_content = False
if in_content:
    rows.append((start, full.height - 1))
print("content bands", rows)

if rows:
    sy0, sy1 = rows[0]
    symbol = full.crop((0, max(0, sy0 - 4), full.width, min(full.height, sy1 + 8)))
    symbol = trim(symbol, pad=4)
else:
    symbol = full.crop((0, 0, full.width, int(full.height * 0.42)))
    symbol = trim(symbol, pad=4)

symbol.save("assets/images/sotongware_symbol.png")
print("symbol", symbol.size)

os.makedirs("web/icons", exist_ok=True)


def make_icon(size, path, maskable=False):
    bg = (0, 0, 0, 0) if not maskable else (11, 31, 74, 255)
    canvas = Image.new("RGBA", (size, size), bg)
    s = symbol.copy()
    pad = int(size * (0.18 if maskable else 0.08))
    target = size - pad * 2
    s.thumbnail((target, target), Image.Resampling.LANCZOS)
    x = (size - s.width) // 2
    y = (size - s.height) // 2
    canvas.paste(s, (x, y), s)
    canvas.save(path)
    print("saved", path, canvas.size)


make_icon(32, "web/favicon.png")
make_icon(192, "web/icons/Icon-192.png")
make_icon(512, "web/icons/Icon-512.png")
make_icon(192, "web/icons/Icon-maskable-192.png", maskable=True)
make_icon(512, "web/icons/Icon-maskable-512.png", maskable=True)
print("done")
