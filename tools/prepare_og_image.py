from PIL import Image, ImageDraw, ImageFont

W, H = 1200, 630
bg = Image.new("RGB", (W, H), (13, 27, 42))
draw = ImageDraw.Draw(bg)

# subtle grid
for y in range(80, H, 80):
    draw.line([(0, y), (W, y)], fill=(30, 55, 80), width=1)
for x in range(100, W, 100):
    draw.line([(x, 0), (x, H)], fill=(30, 55, 80), width=1)

logo = Image.open("assets/images/sotongware_logo_full.png").convert("RGBA")
# place on light plate
plate_w, plate_h = 280, 300
plate = Image.new("RGBA", (plate_w, plate_h), (247, 248, 250, 255))
logo_fit = logo.copy()
logo_fit.thumbnail((220, 250), Image.Resampling.LANCZOS)
px = (plate_w - logo_fit.width) // 2
py = (plate_h - logo_fit.height) // 2
plate.paste(logo_fit, (px, py), logo_fit)

# rounded plate approx by mask
mask = Image.new("L", (plate_w, plate_h), 0)
md = ImageDraw.Draw(mask)
md.rounded_rectangle((0, 0, plate_w - 1, plate_h - 1), radius=28, fill=255)
rounded = Image.new("RGBA", (plate_w, plate_h), (0, 0, 0, 0))
rounded.paste(plate, (0, 0), mask)

bx, by = 90, (H - plate_h) // 2
bg.paste(rounded, (bx, by), rounded)

# text area
try:
    font_title = ImageFont.truetype("malgun.ttf", 48)
    font_sub = ImageFont.truetype("malgun.ttf", 26)
    font_small = ImageFont.truetype("malgun.ttf", 22)
except OSError:
    try:
        font_title = ImageFont.truetype("C:/Windows/Fonts/malgun.ttf", 48)
        font_sub = ImageFont.truetype("C:/Windows/Fonts/malgun.ttf", 26)
        font_small = ImageFont.truetype("C:/Windows/Fonts/malgun.ttf", 22)
    except OSError:
        font_title = ImageFont.load_default()
        font_sub = font_title
        font_small = font_title

tx = 430
draw.text((tx, 210), "소통웨어 산업자동화", font=font_title, fill=(255, 255, 255))
draw.text(
    (tx, 280),
    "맞춤형 산업자동화 소프트웨어",
    font=font_sub,
    fill=(77, 166, 255),
)
draw.text(
    (tx, 340),
    "PLC · 설비 데이터 수집 · 모니터링 · 이력 관리",
    font=font_small,
    fill=(180, 196, 214),
)
draw.text((tx, 390), "sotongware.com", font=font_small, fill=(120, 160, 210))

bg.save("web/assets/og-image.png", quality=92)
print("saved web/assets/og-image.png")
